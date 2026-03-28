package dev.uit.project.controller;

import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import dev.uit.project.service.PdfService;

@RestController
@RequestMapping("/api/export")
@CrossOrigin(origins = "*")
public class PdfController {
    private final PdfService pdfService;

    public PdfController(PdfService pdfService) {
        this.pdfService = pdfService;
    }
    
    private ResponseEntity<byte[]> getFile(byte[] pdf) {
        return ResponseEntity.ok()
            .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=invoice.pdf")
            .contentType(MediaType.APPLICATION_PDF)
            .body(pdf);
    }

    @GetMapping("/booking/{id}/invoice")
    public ResponseEntity<byte[]> exportInvoice(@PathVariable Long id) {
        try {
            byte[] pdf = pdfService.generateInvoice(id);
            return getFile(pdf);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }

    @GetMapping("/booking/{id}/info")
    public ResponseEntity<byte[]> exporto(@PathVariable Long id) {
        try {
            byte[] pdf = pdfService.generateInfo(id);
            return getFile(pdf);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }
}
