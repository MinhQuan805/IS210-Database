package dev.uit.project.controller.admin;

import dev.uit.project.domain.Policy;
import dev.uit.project.domain.dto.PolicyDTO;
import dev.uit.project.service.PolicyService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/admin/policies")
@CrossOrigin(origins = "*")
public class PolicyController {

    private final PolicyService policyService;

    public PolicyController(PolicyService policyService) {
        this.policyService = policyService;
    }

    @GetMapping
    public ResponseEntity<List<PolicyDTO>> getAllPolicies() {
        return ResponseEntity.ok(policyService.getAllPolicies());
    }

    @GetMapping("/type/{type}")
    public ResponseEntity<List<PolicyDTO>> getPoliciesByType(@PathVariable Policy.PolicyType type) {
        return ResponseEntity.ok(policyService.getPoliciesByType(type));
    }

    @GetMapping("/{id}")
    public ResponseEntity<PolicyDTO> getPolicyById(@PathVariable Long id) {
        return ResponseEntity.ok(policyService.getPolicyById(id));
    }

    @PostMapping
    public ResponseEntity<PolicyDTO> createPolicy(@RequestBody Map<String, String> body) {
        Policy.PolicyType type = Policy.PolicyType.valueOf(body.get("type"));
        return ResponseEntity.ok(policyService.createPolicy(type,
                body.get("title"), body.get("content"), body.get("language")));
    }

    @PutMapping("/{id}")
    public ResponseEntity<PolicyDTO> updatePolicy(@PathVariable Long id,
                                                   @RequestBody Map<String, String> body) {
        return ResponseEntity.ok(policyService.updatePolicy(id,
                body.get("title"), body.get("content"), body.get("language")));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePolicy(@PathVariable Long id) {
        policyService.deletePolicy(id);
        return ResponseEntity.noContent().build();
    }

    @PutMapping("/{id}/publish")
    public ResponseEntity<PolicyDTO> publishPolicy(@PathVariable Long id) {
        return ResponseEntity.ok(policyService.publishPolicy(id));
    }
}
