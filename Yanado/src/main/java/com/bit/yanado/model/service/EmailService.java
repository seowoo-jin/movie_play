package com.bit.yanado.model.service;

import com.bit.yanado.model.dto.EmailDTO;

public interface EmailService {
    public void sendMail(EmailDTO dto);
}