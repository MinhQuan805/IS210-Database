package dev.uit.project.service;

import java.text.NumberFormat;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.stereotype.Service;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import dev.uit.project.domain.Payment;
import dev.uit.project.domain.dto.BookingDTO;
import dev.uit.project.domain.dto.CustomerDTO;
import dev.uit.project.service.pdf.PdfComponents;
import dev.uit.project.service.pdf.PdfComponents.DocumentContext;
import dev.uit.project.service.pdf.PdfComponents.Fonts;
import jakarta.transaction.Transactional;

@Service
public class PdfService {

    private final CustomerService customerService;
    private final BookingService  bookingService;

    public PdfService(CustomerService customerService, BookingService bookingService) {
        this.customerService = customerService;
        this.bookingService  = bookingService;
    }

    @Transactional
    public byte[] generateInvoice(Long bookingId) throws Exception {
        BookingDTO    booking  = bookingService.getBookingById(bookingId);
        CustomerDTO   customer = customerService.getCustomerById(booking.getCustomerId());
        List<Payment> payments = booking.getPayments();

        DocumentContext ctx = DocumentContext.create();
        ctx.document.open();
        Fonts fonts = Fonts.load(getClass());

        // — Header —
        for (Element e : PdfComponents.buildHeader(fonts)) ctx.document.add(e);

        // — Tiêu đề —
        ctx.document.add(PdfComponents.buildTitle("HÓA ĐƠN THANH TOÁN", fonts));

        // — Thông tin khách hàng + booking —
        ctx.document.add(PdfComponents.buildInfoTable(
            customer.getLastName() + " " + customer.getFirstName(),
            customer.getPhone(),
            customer.getEmail(),
            String.valueOf(booking.getId()),
            booking.getRoomNumber() + " (" + booking.getRoomTypeName() + ")",
            booking.getCheckInDate().format(ctx.dateOnlyFmt),
            booking.getCheckOutDate().format(ctx.dateOnlyFmt),
            fonts
        ));

        // — Bảng chi tiết thanh toán —
        ctx.document.add(buildPaymentTable(payments, fonts, ctx.fullFmt, ctx.currency));

        // — Tổng cộng —
        ctx.document.add(PdfComponents.buildTotalTable(
            ctx.currency.format(booking.getRawPrice()),
            "-" + ctx.currency.format(booking.getDiscountAmount()),
            ctx.currency.format(booking.getTotalPrice()),
            fonts
        ));

        // — Footer —
        ctx.document.add(PdfComponents.buildFooter(fonts));

        ctx.document.close();
        return ctx.toByteArray();
    }

    @Transactional
    public byte[] generateInfo(Long bookingId) throws Exception {
        BookingDTO  booking  = bookingService.getBookingById(bookingId);
        CustomerDTO customer = customerService.getCustomerById(booking.getCustomerId());

        DocumentContext ctx = DocumentContext.create();
        ctx.document.open();
        Fonts fonts = Fonts.load(getClass());

        for (Element e : PdfComponents.buildHeader(fonts)) ctx.document.add(e);
        ctx.document.add(PdfComponents.buildTitle("THÔNG TIN ĐẶT PHÒNG", fonts));
        ctx.document.add(PdfComponents.buildInfoTable(
            customer.getLastName() + " " + customer.getFirstName(),
            customer.getPhone(),
            customer.getEmail(),
            String.valueOf(booking.getId()),
            booking.getRoomNumber() + " (" + booking.getRoomTypeName() + ")",
            booking.getCheckInDate().format(ctx.dateOnlyFmt),
            booking.getCheckOutDate().format(ctx.dateOnlyFmt),
            fonts
        ));
        ctx.document.add(PdfComponents.buildFooter(fonts));

        ctx.document.close();
        return ctx.toByteArray();
    }

    // -------------------------------------------------------------------------
    // Private helpers (chỉ liên quan invoice, không đủ generic để vào Component)
    // -------------------------------------------------------------------------

    private PdfPTable buildPaymentTable(List<Payment> payments, Fonts fonts,
                                        DateTimeFormatter fmt, NumberFormat currency)
            throws DocumentException {

        PdfPTable table = new PdfPTable(3);
        table.setWidthPercentage(100);
        table.setWidths(new float[]{3, 2, 2});

        // Header row
        for (String h : new String[]{"Mô tả", "Ngày thanh toán", "Số tiền"}) {
            PdfPCell cell = new PdfPCell(new Phrase(h, fonts.bold));
            cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
            cell.setPadding(8);
            table.addCell(cell);
        }

        // Data rows
        if (payments != null && !payments.isEmpty()) {
            for (Payment p : payments) {
                table.addCell(new PdfPCell(new Phrase("Thanh toán đợt " + p.getId(), fonts.content)));
                table.addCell(new PdfPCell(new Phrase(p.getPaymentDate().format(fmt), fonts.content)));

                PdfPCell priceCell = new PdfPCell(new Phrase(currency.format(p.getAmount()), fonts.content));
                priceCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table.addCell(priceCell);
            }
        } else {
            PdfPCell empty = new PdfPCell(new Phrase("Chưa có dữ liệu thanh toán", fonts.italic));
            empty.setColspan(3);
            table.addCell(empty);
        }

        return table;
    }
}