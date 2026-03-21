package dev.uit.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import dev.uit.project.domain.dto.FaqDTO;
import dev.uit.project.repository.FaqRepository;
import jakarta.transaction.Transactional;

@Service
public class FaqService {
    private final FaqRepository faqRepository;

    public FaqService(FaqRepository faqRepository) {
        this.faqRepository = faqRepository;
    }

    @Transactional
    public List<FaqDTO> getAllFaqs() {
        return faqRepository.findAll().stream().map(FaqDTO::fromEntity).toList();
    }

    @Transactional
    public List<FaqDTO> getAllActiveFaqs() {
        return faqRepository.findAll().stream()
            .filter(f -> f.getIsActive() == 1)
            .map(FaqDTO::fromEntity)
            .toList();
    }
}
