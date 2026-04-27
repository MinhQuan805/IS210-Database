package dev.uit.project.service.pdf;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.itextpdf.text.pdf.draw.LineSeparator;

import java.io.ByteArrayOutputStream;
import java.text.NumberFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

public final class PdfComponents {

    private PdfComponents() {}

    // -------------------------------------------------------------------------
    // FONTS
    // -------------------------------------------------------------------------

    public static final class Fonts {
        private static final String BOLD_PATH    = "/fonts/segoeuithibd.ttf";
        private static final String REGULAR_PATH = "/fonts/segoeuithis.ttf";

        public final Font title;
        public final Font content;
        public final Font bold;
        public final Font italic;

        private Fonts(Font title, Font content, Font bold, Font italic) {
            this.title   = title;
            this.content = content;
            this.bold    = bold;
            this.italic  = italic;
        }

        /**
         * Khởi tạo bộ font từ classpath.
         * Gọi một lần duy nhất rồi truyền vào các component khác.
         */
        public static Fonts load(Class<?> resourceLoader) throws DocumentException, java.io.IOException {
            BaseFont titleBase = BaseFont.createFont(
                resourceLoader.getResource(BOLD_PATH).toExternalForm(),
                BaseFont.IDENTITY_H, BaseFont.EMBEDDED);

            BaseFont contentBase = BaseFont.createFont(
                resourceLoader.getResource(REGULAR_PATH).toExternalForm(),
                BaseFont.IDENTITY_H, BaseFont.EMBEDDED);

            return new Fonts(
                new Font(titleBase,   20, Font.BOLD,   BaseColor.DARK_GRAY),
                new Font(contentBase, 11, Font.NORMAL),
                new Font(contentBase, 11, Font.BOLD),
                new Font(contentBase, 10, Font.ITALIC)
            );
        }
    }

    // -------------------------------------------------------------------------
    // DOCUMENT CONTEXT — document + writer + formatters dùng chung
    // -------------------------------------------------------------------------

    /**
     * Đóng gói toàn bộ "scaffolding" cần thiết để tạo một PDF.
     * <p>Cách dùng:
     * <pre>
     *   DocumentContext ctx = DocumentContext.create();
     *   ctx.document.open();
     *   // ... thêm nội dung ...
     *   ctx.document.close();
     *   return ctx.toByteArray();
     * </pre>
     */
    public static final class DocumentContext {

        public final ByteArrayOutputStream out;
        public final Document              document;
        public final NumberFormat          currency;
        public final DateTimeFormatter     fullFmt;
        public final DateTimeFormatter     dateOnlyFmt;

        private DocumentContext(ByteArrayOutputStream out, Document document,
                                NumberFormat currency,
                                DateTimeFormatter fullFmt,
                                DateTimeFormatter dateOnlyFmt) {
            this.out         = out;
            this.document    = document;
            this.currency    = currency;
            this.fullFmt     = fullFmt;
            this.dateOnlyFmt = dateOnlyFmt;
        }

        /**
         * Khởi tạo Document A4 chuẩn (margin 36pt) kèm các formatter VN.
         * Gọi {@code ctx.document.open()} ngay sau khi nhận về.
         */
        public static DocumentContext create() throws DocumentException {
            ByteArrayOutputStream out      = new ByteArrayOutputStream();
            Document              document = new Document(PageSize.A4, 36, 36, 36, 36);
            PdfWriter.getInstance(document, out);

            NumberFormat      currency    = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
            DateTimeFormatter fullFmt     = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
            DateTimeFormatter dateOnlyFmt = DateTimeFormatter.ofPattern("dd/MM/yyyy");

            return new DocumentContext(out, document, currency, fullFmt, dateOnlyFmt);
        }

        /** Lấy bytes sau khi đã {@code document.close()}. */
        public byte[] toByteArray() {
            return out.toByteArray();
        }
    }

    // -------------------------------------------------------------------------
    // HEADER — logo + địa chỉ khách sạn + ngày xuất
    // -------------------------------------------------------------------------

    /**
     * Tạo header chuẩn: tên khách sạn (trái) + ngày xuất (phải) + đường kẻ.
     * Thêm vào document bằng: document.add(buildHeader(fonts));
     */
    public static Element[] buildHeader(Fonts fonts) throws DocumentException {
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");

        PdfPTable table = new PdfPTable(2);
        table.setWidthPercentage(100);
        table.setWidths(new float[]{2, 1});

        // Cột trái
        PdfPCell left = new PdfPCell();
        left.setBorder(Rectangle.NO_BORDER);
        left.addElement(new Paragraph("LUMINA SUITES®", fonts.title));
        left.addElement(new Paragraph("Địa chỉ: 2 Công trường Lam Sơn, P. Bến Nghé, TP. Hồ Chí Minh", fonts.content));
        left.addElement(new Paragraph("Hotline: 02838241234 | Web: lumina-suites.org", fonts.content));
        table.addCell(left);

        // Cột phải
        PdfPCell right = new PdfPCell();
        right.setBorder(Rectangle.NO_BORDER);
        right.setHorizontalAlignment(Element.ALIGN_RIGHT);
        Paragraph date = new Paragraph("Ngày xuất: " + LocalDateTime.now().format(fmt), fonts.italic);
        date.setAlignment(Element.ALIGN_RIGHT);
        right.addElement(date);
        table.addCell(right);

        // Trả về [table, separator, spacer] để caller add tuần tự
        return new Element[]{
            table,
            new Chunk(new LineSeparator()),
            new Paragraph(" ")
        };
    }

    // -------------------------------------------------------------------------
    // TITLE — tiêu đề trung tâm (VD: "HÓA ĐƠN THANH TOÁN")
    // -------------------------------------------------------------------------

    public static Paragraph buildTitle(String text, Fonts fonts) {
        Paragraph p = new Paragraph(text, fonts.title);
        p.setAlignment(Element.ALIGN_CENTER);
        p.setSpacingAfter(20);
        return p;
    }

    // -------------------------------------------------------------------------
    // INFO TABLE — khách hàng (trái) + booking (phải)
    // -------------------------------------------------------------------------

    public static PdfPTable buildInfoTable(
            String customerName, String phone, String email,
            String bookingId, String roomInfo, String checkIn, String checkOut,
            Fonts fonts) throws DocumentException {

        PdfPTable table = new PdfPTable(2);
        table.setWidthPercentage(100);
        table.setSpacingAfter(20);

        // Khách hàng
        PdfPCell cCell = new PdfPCell();
        cCell.setBorder(Rectangle.NO_BORDER);
        cCell.addElement(new Paragraph("KHÁCH HÀNG", fonts.bold));
        cCell.addElement(new Paragraph(customerName, fonts.content));
        cCell.addElement(new Paragraph("SĐT: " + phone, fonts.content));
        cCell.addElement(new Paragraph("Email: " + email, fonts.content));
        table.addCell(cCell);

        // Booking
        PdfPCell bCell = new PdfPCell();
        bCell.setBorder(Rectangle.NO_BORDER);
        bCell.addElement(new Paragraph("CHI TIẾT ĐẶT PHÒNG", fonts.bold));
        bCell.addElement(new Paragraph("Mã đặt phòng: #" + bookingId, fonts.content));
        bCell.addElement(new Paragraph("Phòng: " + roomInfo, fonts.content));
        bCell.addElement(new Paragraph("Check-in: " + checkIn, fonts.content));
        bCell.addElement(new Paragraph("Check-out: " + checkOut, fonts.content));
        table.addCell(bCell);

        return table;
    }

    // -------------------------------------------------------------------------
    // TOTAL TABLE — tạm tính / giảm giá / tổng
    // -------------------------------------------------------------------------

    public static PdfPTable buildTotalTable(
            String subtotal, String discount, String total,
            Fonts fonts) throws DocumentException {

        PdfPTable table = new PdfPTable(2);
        table.setWidthPercentage(100);
        table.setSpacingBefore(10);
        table.setWidths(new float[]{4, 2});

        addTotalRow(table, "Tạm tính:",          subtotal,  fonts.content, false);
        addTotalRow(table, "Giảm giá:",           discount,  fonts.content, false);
        addTotalRow(table, "TỔNG THANH TOÁN:",    total,     fonts.bold,    true);

        return table;
    }

    /** Helper nội bộ — thêm một hàng label + value vào bảng tổng. */
    private static void addTotalRow(PdfPTable table, String label, String value,
                                    Font font, boolean hasBorder) {
        PdfPCell lCell = new PdfPCell(new Phrase(label, font));
        lCell.setBorder(Rectangle.NO_BORDER);
        lCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        lCell.setPadding(5);
        table.addCell(lCell);

        PdfPCell vCell = new PdfPCell(new Phrase(value, font));
        vCell.setBorder(hasBorder ? Rectangle.BOX : Rectangle.NO_BORDER);
        vCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        vCell.setPadding(5);
        table.addCell(vCell);
    }

    // -------------------------------------------------------------------------
    // FOOTER
    // -------------------------------------------------------------------------

    public static Paragraph buildFooter(Fonts fonts) {
        Paragraph footer = new Paragraph(
            "\n\nCảm ơn quý khách đã lựa chọn Lumina Suites®!\nHy vọng sớm được phục vụ quý khách lần sau.",
            fonts.content);
        footer.setAlignment(Element.ALIGN_CENTER);
        footer.setSpacingBefore(40);
        return footer;
    }
}