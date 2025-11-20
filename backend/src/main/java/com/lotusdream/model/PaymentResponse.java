package com.lotusdream.model;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PaymentResponse {

    private String status;
    private String orderId;
    private Double amount;
    private String currency;
    private String receipt;
    private Integer entries;
    private String method;
    private String userId;
    private String message;
}

