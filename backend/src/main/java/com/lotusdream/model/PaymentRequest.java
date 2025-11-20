package com.lotusdream.model;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class PaymentRequest {

    @NotNull(message = "Amount is required")
    @Min(value = 1, message = "Amount must be at least ₹1")
    private Double amount;

    @NotBlank(message = "Payment method is required")
    private String method;  // GPay / PhonePe / Paytm

    @NotNull(message = "Entries count is required")
    @Min(value = 1, message = "At least 1 entry is required")
    private Integer entries;

    @NotBlank(message = "User ID is required")
    private String userId;
}
