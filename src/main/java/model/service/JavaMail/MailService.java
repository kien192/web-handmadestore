package model.service.JavaMail;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;
import java.util.Properties;
import java.util.Random;

public class MailService {
    public boolean send(String to, String subject, String messageContent) {
        try {
            // Get properties object
            Properties props = new Properties();
            props.put("mail.smtp.auth", MailProperties.auth);
            props.put("mail.smtp.starttls.enable", MailProperties.ssl);
            props.put("mail.smtp.host", MailProperties.host);
            props.put("mail.smtp.port", MailProperties.port);

            // get Session
            Session session = Session.getInstance(props,
                    new Authenticator() {
                        @Override
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(MailProperties.username, MailProperties.password);
                        }
                    });

            // compose message
            Message message = new MimeMessage(session);

            message.setFrom(new InternetAddress(MailProperties.username, "Hand Made Store"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
//            Vì bold bằng html nên thay vì setText thì setsetContent bên dưới
//            message.setText(messageContent);
            // Thiết lập nội dung là HTML
            message.setContent(messageContent, "text/html; charset=utf-8");
            // send message
            Transport.send(message);
            return true;
        } catch (MessagingException | UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
    }

    public static String getRandomCode(int length) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < length; i++) {
            int index = random.nextInt(characters.length());
            sb.append(characters.charAt(index));
        }
        return sb.toString();
    }

    public static String sendCode(String to) {
        String code = getRandomCode(5);
        MailService emailService = new MailService();
        emailService.send(to, "Xác thực email", "Chào bạn,<br> Đây là mã xác thực từ Handmadestore, vui lòng không cung cấp mã xác thực cho người khác và chỉ có giá trị sử dụng cho 1 lần: " +
                "<br> <strong>" + code + "</strong>");

        return code;
    }

    public static void main(String[] args) {
        System.out.println(sendCode("lebatrong2003@gmail.com"));
    }
}