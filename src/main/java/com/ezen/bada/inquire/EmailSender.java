package com.ezen.bada.inquire;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class EmailSender {

	//sendEmail1: 문의가 접수되었다는 메일을 보내는 메소드
    public static void sendEmail1(String name, String recipientEmail, String title, String category, String content) {
        final String username = "ezen.bada@gmail.com"; // 저희 지메일
        final String password = "sozi xbns ptqf sozn"; // 계정 비밀번호가 아니라 앱암호라고 뭐 생성하는 거...

        // SMTP 서버 설정
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Gmail 계정으로 세션 생성
        Session session = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        try {
            // 이메일 메시지 생성
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username)); // 보내는 이: 우리 이메일
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(recipientEmail)); // 받는 이: 이메일 센더로 가져온 String email=String recipientEmail
            message.setSubject(name+" 고객님의 문의가 접수되었습니다."); // 이메일 제목
            message.setText(name+" 고객님! 안녕하세요. <바라는 바다!> 개발팀입니다.\n"
            		+ "고객님의 ["+title+ "] 문의가 성공적으로 접수되었습니다.\n\n"
            		+ "고객님께서 문의 주신 사안은 ["+category+"]에 대한 문의 사항이며, 자세한 문의 내용은 다음과 같습니다. \n\n [문의 내용: "
            		+ content +"] \n \n"
            		+ "해당 문의에 대해 빠른 시일 내에 답변 드릴 예정이며, 더 문의하실 사항이 있다면 회신해주시기 바랍니다. \n"
            		+ "문의해 주셔서 감사합니다. \n\n"
            		+ "-<바라는 바다!> 개발팀"); // 이메일 내용

            // 이메일 전송
            Transport.send(message);

            System.out.println("문의 접수 이메일 전송 완료");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
    
    
    
  //sendEmail2: 문의에 대한 답장을 보내는 메소드
    public static void sendEmail2(String name, String recipientEmail, String title, String category, String content, String reply) {
        final String username = "ezen.bada@gmail.com"; // 저희 지메일
        final String password = "sozi xbns ptqf sozn"; // 계정 비밀번호가 아니라 앱암호라고 뭐 생성하는 거...

        // SMTP 서버 설정
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Gmail 계정으로 세션 생성
        Session session = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        try {
            // 이메일 메시지 생성
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username)); // 보내는 이: 우리 이메일
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(recipientEmail)); // 받는 이: 이메일 센더로 가져온 String email=String recipientEmail
            message.setSubject(name+" 고객님, <바라는 바다!>에서 고객님의 문의에 답변 드립니다."); // 이메일 제목
            message.setText(name+" 고객님! 안녕하세요. <바라는 바다!> 개발팀입니다.\n"
            		+ "고객님의 ["+title+ "] 문의에 대한 답이 도착하였습니다.\n\n"
            		+ "고객님께서 문의 주신 사안은 ["+category+"]에 대한 문의 사항이며, 자세한 문의 내용은 다음과 같습니다. \n\n [문의 내용: "
            		+ content +"] \n \n \n"
            		+ "해당 문의에 대한 답변을 다음과 같이 전송드립니다. \n\n [답변: "
            		+ reply +"] \n \n"
            		+ "문의해 주셔서 감사합니다. 더 문의하실 사항이 있다면 회신해주시기 바랍니다.\n\n"
            		+ "-<바라는 바다!> 개발팀"); // 이메일 내용

            // 이메일 전송
            Transport.send(message);

            System.out.println("문의 답변 이메일 전송 완료");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
    
    
    
}
