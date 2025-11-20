package com.lotusdream.services;

import com.lotusdream.dto.PaymentRequest;
import com.lotusdream.dto.PaymentResponse;
import com.lotusdream.exceptions.PaymentException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class PaymentService {

    private static final Logger logger = LoggerFactory.getLogger(PaymentService.class);

    @Value("${razorpay.key_id}")
    private String razorpayKeyId;

    @Value("${razorpay.key_secret}")
    private String razorpayKeySecret;

    public PaymentResponse processPayment(PaymentRequest request) {
        try {
            // RazorpayClient client = new RazorpayClient(razorpayKeyId, razorpayKeySecret);
            // JSONObject orderRequest = new JSONObject();
            // orderRequest.put("amount", request.getAmount());
            // orderRequest.put("currency", request.getCurrency());
            // orderRequest.put("receipt", request.getReceipt());
            // Order order = client.Orders.create(orderRequest);

            PaymentResponse response = new PaymentResponse();
            response.setStatus("CREATED");
            response.setOrderId("order_test_123"); // Replace with real ID from Razorpay
            return response;
        } catch (Exception e) {
            logger.error("Payment creation failed", e);
            throw new PaymentException("Failed to create payment order");
        }
    }
}
