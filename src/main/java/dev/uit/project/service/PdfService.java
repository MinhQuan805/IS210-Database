package dev.uit.project.service;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.text.NumberFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;

import org.springframework.stereotype.Service;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.draw.LineSeparator;

import dev.uit.project.domain.Payment;
import dev.uit.project.domain.dto.BookingDTO;
import dev.uit.project.domain.dto.CustomerDTO;
import jakarta.transaction.Transactional;

@Service
public class PdfService {

    private final CustomerService customerService;
    private final BookingService bookingService;

    public PdfService(CustomerService customerService, BookingService bookingService) {
        this.customerService = customerService;
        this.bookingService = bookingService;
    }

    private void addTotalRow(PdfPTable table, String label, String value, Font font, boolean hasBorder) {
        PdfPCell labelCell = new PdfPCell(new Phrase(label, font));
        labelCell.setBorder(Rectangle.NO_BORDER);
        labelCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        labelCell.setPadding(5);
        table.addCell(labelCell);

        PdfPCell valueCell = new PdfPCell(new Phrase(value, font));
        if (!hasBorder) valueCell.setBorder(Rectangle.NO_BORDER);
        valueCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        valueCell.setPadding(5);
        table.addCell(valueCell);
    }

    @Transactional
    public byte[] generateInvoice(Long bookingId) throws Exception {
        BookingDTO booking = bookingService.getBookingById(bookingId);
        CustomerDTO customer = customerService.getCustomerById(booking.getCustomerId());
        List<Payment> payments = booking.getPayments();

        ByteArrayOutputStream out = new ByteArrayOutputStream();
        Document document = new Document(PageSize.A4, 36, 36, 36, 36);
        PdfWriter.getInstance(document, out);

        document.open();

        // 1. Khai báo Font (Sử dụng lại config của bạn)
        BaseFont titleBaseFont = BaseFont.createFont(getClass().getResource("/fonts/segoeuithibd.ttf").toExternalForm(), BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        Font titleFont = new Font(titleBaseFont, 20, Font.BOLD, BaseColor.DARK_GRAY);
        
        BaseFont contentBaseFont = BaseFont.createFont(getClass().getResource("/fonts/segoeuithis.ttf").toExternalForm(), BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        Font contentFont = new Font(contentBaseFont, 11);
        Font boldFont = new Font(contentBaseFont, 11, Font.BOLD);
        Font italicFont = new Font(contentBaseFont, 10, Font.ITALIC);

        // Định dạng tiền tệ và ngày tháng
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        DateTimeFormatter fullDtFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
        DateTimeFormatter dateOnlyFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        // 2. HEADER - Thông tin khách sạn
        PdfPTable headerTable = new PdfPTable(2);
        headerTable.setWidthPercentage(100);
        headerTable.setWidths(new float[]{2, 1});

        // Cột trái: Tên khách sạn & Địa chỉ
        PdfPCell hotelInfoCell = new PdfPCell();
        hotelInfoCell.setBorder(Rectangle.NO_BORDER);
        hotelInfoCell.addElement(new Paragraph("LUMINA SUITES®", titleFont));
        hotelInfoCell.addElement(new Paragraph("Địa chỉ: 2 Công trường Lam Sơn, P. Bến Nghé, TP. Hồ Chí Minh", contentFont));
        hotelInfoCell.addElement(new Paragraph("Hotline: 02838241234 | Web: lumina-suites.org", contentFont));
        headerTable.addCell(hotelInfoCell);

        // Cột phải: Ngày xuất hóa đơn
        PdfPCell dateCell = new PdfPCell();
        dateCell.setBorder(Rectangle.NO_BORDER);
        dateCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        Paragraph invoiceDate = new Paragraph("Ngày xuất: " + LocalDateTime.now().format(fullDtFormatter), italicFont);
        invoiceDate.setAlignment(Element.ALIGN_RIGHT);
        dateCell.addElement(invoiceDate);
        headerTable.addCell(dateCell);
        
        document.add(headerTable);
        document.add(new Chunk(new LineSeparator())); // Đường kẻ ngang
        document.add(new Paragraph(" ")); // Khoảng trống

        // 3. TIÊU ĐỀ HÓA ĐƠN
        Paragraph mainTitle = new Paragraph("HÓA ĐƠN THANH TOÁN", titleFont);
        mainTitle.setAlignment(Element.ALIGN_CENTER);
        mainTitle.setSpacingAfter(20);
        document.add(mainTitle);

        // 4. THÔNG TIN KHÁCH HÀNG & BOOKING (Dùng Table cho đẹp)
        PdfPTable infoTable = new PdfPTable(2);
        infoTable.setWidthPercentage(100);
        infoTable.setSpacingAfter(20);

        // Customer Side
        PdfPCell cCell = new PdfPCell();
        cCell.setBorder(Rectangle.NO_BORDER);
        cCell.addElement(new Paragraph("KHÁCH HÀNG", boldFont));
        cCell.addElement(new Paragraph(customer.getLastName() + " " + customer.getFirstName(), contentFont));
        cCell.addElement(new Paragraph("SĐT: " + customer.getPhone(), contentFont));
        cCell.addElement(new Paragraph("Email: " + customer.getEmail(), contentFont));
        infoTable.addCell(cCell);

        // Booking Side
        PdfPCell bCell = new PdfPCell();
        bCell.setBorder(Rectangle.NO_BORDER);
        bCell.addElement(new Paragraph("CHI TIẾT ĐẶT PHÒNG", boldFont));
        bCell.addElement(new Paragraph("Mã đặt phòng: #" + booking.getId(), contentFont));
        bCell.addElement(new Paragraph("Phòng: " + booking.getRoomNumber() + " (" + booking.getRoomTypeName() + ")", contentFont));
        bCell.addElement(new Paragraph("Check-in: " + booking.getCheckInDate().format(dateOnlyFormatter), contentFont));
        bCell.addElement(new Paragraph("Check-out: " + booking.getCheckOutDate().format(dateOnlyFormatter), contentFont));
        infoTable.addCell(bCell);

        document.add(infoTable);

        // 5. CHI TIẾT THANH TOÁN (Table)
        PdfPTable paymentTable = new PdfPTable(3);
        paymentTable.setWidthPercentage(100);
        paymentTable.setWidths(new float[]{3, 2, 2});
        
        // Header Table
        String[] headers = {"Mô tả", "Ngày thanh toán", "Số tiền"};
        for (String header : headers) {
            PdfPCell cell = new PdfPCell(new Phrase(header, boldFont));
            cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
            cell.setPadding(8);
            paymentTable.addCell(cell);
        }

        // Duyệt danh sách payments
        if (payments != null && !payments.isEmpty()) {
            for (Payment p : payments) {
                paymentTable.addCell(new PdfPCell(new Phrase("Thanh toán đợt " + p.getId(), contentFont)));
                paymentTable.addCell(new PdfPCell(new Phrase(p.getPaymentDate().format(fullDtFormatter), contentFont)));
                PdfPCell priceCell = new PdfPCell(new Phrase(currencyFormat.format(p.getAmount()), contentFont));
                priceCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                paymentTable.addCell(priceCell);
            }
        } else {
            PdfPCell emptyCell = new PdfPCell(new Phrase("Chưa có dữ liệu thanh toán", italicFont));
            emptyCell.setColspan(3);
            paymentTable.addCell(emptyCell);
        }

        document.add(paymentTable);

        // 6. TỔNG CỘNG
        PdfPTable totalTable = new PdfPTable(2);
        totalTable.setWidthPercentage(100);
        totalTable.setSpacingBefore(10);
        totalTable.setWidths(new float[]{4, 2});

        // Helper function để add dòng tổng
        addTotalRow(totalTable, "Tạm tính:", currencyFormat.format(booking.getRawPrice()), contentFont, false);
        addTotalRow(totalTable, "Giảm giá:", "-" + currencyFormat.format(booking.getDiscountAmount()), contentFont, false);
        addTotalRow(totalTable, "TỔNG THANH TOÁN:", currencyFormat.format(booking.getTotalPrice()), boldFont, true);

        document.add(totalTable);

        // 7. FOOTER
        Paragraph footer = new Paragraph("\n\nCảm ơn quý khách đã lựa chọn Lumina Suites®!\nHy vọng sớm được phục vụ quý khách lần sau.", contentFont);
        footer.setAlignment(Element.ALIGN_CENTER);
        footer.setSpacingBefore(40);
        document.add(footer);

        document.close();
        return out.toByteArray();
    }

    @Transactional
    public byte[] generateInfo(Long bookingId) throws Exception {
        BookingDTO booking = bookingService.getBookingById(bookingId);
        CustomerDTO customer = customerService.getCustomerById(booking.getCustomerId());

        ByteArrayOutputStream out = new ByteArrayOutputStream();
        Document document = new Document(PageSize.A4, 36, 36, 36, 36);
        PdfWriter.getInstance(document, out);

        document.open();

        // 1. Khai báo Font (Sử dụng lại config của bạn)
        BaseFont titleBaseFont = BaseFont.createFont(getClass().getResource("/fonts/segoeuithibd.ttf").toExternalForm(), BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        Font titleFont = new Font(titleBaseFont, 20, Font.BOLD, BaseColor.DARK_GRAY);
        
        BaseFont contentBaseFont = BaseFont.createFont(getClass().getResource("/fonts/segoeuithis.ttf").toExternalForm(), BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        Font contentFont = new Font(contentBaseFont, 11);
        Font boldFont = new Font(contentBaseFont, 11, Font.BOLD);
        Font italicFont = new Font(contentBaseFont, 10, Font.ITALIC);

        // Định dạng tiền tệ và ngày tháng
        DateTimeFormatter fullDtFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
        DateTimeFormatter dateOnlyFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        // 2. HEADER - Thông tin khách sạn
        PdfPTable headerTable = new PdfPTable(2);
        headerTable.setWidthPercentage(100);
        headerTable.setWidths(new float[]{2, 1});

        // Cột trái: Tên khách sạn & Địa chỉ
        PdfPCell hotelInfoCell = new PdfPCell();
        hotelInfoCell.setBorder(Rectangle.NO_BORDER);
        hotelInfoCell.addElement(new Paragraph("LUMINA SUITES®", titleFont));
        hotelInfoCell.addElement(new Paragraph("Địa chỉ: 2 Công trường Lam Sơn, P. Bến Nghé, TP. Hồ Chí Minh", contentFont));
        hotelInfoCell.addElement(new Paragraph("Hotline: 02838241234 | Web: lumina-suites.org", contentFont));
        headerTable.addCell(hotelInfoCell);

        // Cột phải: Ngày xuất hóa đơn
        PdfPCell dateCell = new PdfPCell();
        dateCell.setBorder(Rectangle.NO_BORDER);
        dateCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        Paragraph invoiceDate = new Paragraph("Ngày xuất: " + LocalDateTime.now().format(fullDtFormatter), italicFont);
        invoiceDate.setAlignment(Element.ALIGN_RIGHT);
        dateCell.addElement(invoiceDate);
        headerTable.addCell(dateCell);
        
        document.add(headerTable);
        document.add(new Chunk(new LineSeparator())); // Đường kẻ ngang
        document.add(new Paragraph(" ")); // Khoảng trống

        // 3. TIÊU ĐỀ HÓA ĐƠN
        Paragraph mainTitle = new Paragraph("THÔNG TIN ĐẶT PHÒNG", titleFont);
        mainTitle.setAlignment(Element.ALIGN_CENTER);
        mainTitle.setSpacingAfter(20);
        document.add(mainTitle);

        // 4. THÔNG TIN KHÁCH HÀNG & BOOKING (Dùng Table cho đẹp)
        PdfPTable infoTable = new PdfPTable(2);
        infoTable.setWidthPercentage(100);
        infoTable.setSpacingAfter(20);

        // Customer Side
        PdfPCell cCell = new PdfPCell();
        cCell.setBorder(Rectangle.NO_BORDER);
        cCell.addElement(new Paragraph("KHÁCH HÀNG", boldFont));
        cCell.addElement(new Paragraph(customer.getLastName() + " " + customer.getFirstName(), contentFont));
        cCell.addElement(new Paragraph("SĐT: " + customer.getPhone(), contentFont));
        cCell.addElement(new Paragraph("Email: " + customer.getEmail(), contentFont));
        infoTable.addCell(cCell);

        // Booking Side
        PdfPCell bCell = new PdfPCell();
        bCell.setBorder(Rectangle.NO_BORDER);
        bCell.addElement(new Paragraph("CHI TIẾT ĐẶT PHÒNG", boldFont));
        bCell.addElement(new Paragraph("Mã đặt phòng: #" + booking.getId(), contentFont));
        bCell.addElement(new Paragraph("Phòng: " + booking.getRoomNumber() + " (" + booking.getRoomTypeName() + ")", contentFont));
        bCell.addElement(new Paragraph("Check-in: " + booking.getCheckInDate().format(dateOnlyFormatter), contentFont));
        bCell.addElement(new Paragraph("Check-out: " + booking.getCheckOutDate().format(dateOnlyFormatter), contentFont));
        infoTable.addCell(bCell);

        document.add(infoTable);

        // 7. FOOTER
        Paragraph footer = new Paragraph("\n\nCảm ơn quý khách đã lựa chọn Lumina Suites®!\nHy vọng sớm được phục vụ quý khách lần sau.", contentFont);
        footer.setAlignment(Element.ALIGN_CENTER);
        footer.setSpacingBefore(40);
        document.add(footer);

        document.close();
        return out.toByteArray();
    }
}
