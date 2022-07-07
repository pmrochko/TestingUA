package com.myproject.testingua.utils.PDF;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfWriter;

import com.myproject.testingua.models.entity.Test;
import com.myproject.testingua.models.entity.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.time.LocalDate;

public class PDFBuilder {

    public static void testResultPDF(HttpServletRequest request, HttpServletResponse response, User user, Test test,
                                     String testStatus, String testResult) {

        Document document = new Document(PageSize.A4, 50, 50, 50, 50);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        try {
            PdfWriter.getInstance(document, baos);
            document.open();

            BaseFont arial = BaseFont.createFont("C:\\Windows\\Fonts\\arial.ttf", "cp1251",
                    BaseFont.EMBEDDED);

            Paragraph title = new Paragraph("TestingUA | Result of the passed test", new Font(arial, 18));
            title.setAlignment(Element.ALIGN_CENTER);
            addEmptyLine(title, 3);
            document.add(title);

            Paragraph testTitle = new Paragraph("Title: " + test.getTitle(), new Font(arial, 16));
            addEmptyLine(testTitle, 1);
            Paragraph testDescription = new Paragraph("Description: " + test.getDescription(), new Font(arial, 16));
            addEmptyLine(testDescription, 1);
            Paragraph subject = new Paragraph("Subject: " + test.getSubject().getName(), new Font(arial, 16));
            addEmptyLine(subject, 1);
            Paragraph difficulty = new Paragraph("Difficulty: " + test.getDifficulty().name(), new Font(arial, 16));
            addEmptyLine(difficulty, 1);
            Paragraph username = new Paragraph("Your name: " + user.getName() + ' ' + user.getSurname(), new Font(arial, 16));
            addEmptyLine(username, 1);
            Paragraph status = new Paragraph("Status: " + testStatus, new Font(arial, 16));
            addEmptyLine(status, 1);
            Paragraph result = new Paragraph("Result score: " + testResult, new Font(arial, 16));
            addEmptyLine(result, 8);

            document.add(testTitle);
            document.add(testDescription);
            document.add(subject);
            document.add(difficulty);
            document.add(username);
            document.add(status);
            document.add(result);

            String imgPath = "C:\\Users\\Asus\\Desktop\\Epam Final Project\\testing_UA\\src\\main\\webapp\\images\\stamp.png";
            Image image = Image.getInstance(imgPath);
            image.setAlignment(Element.ALIGN_RIGHT);
            image.scaleAbsolute(150f, 150f);
            document.add(image);
            addEmptyLine(result, 2);

            Paragraph footer = new Paragraph("© TestingUA 2022", new Font(arial, 12));
            footer.setAlignment(Element.ALIGN_CENTER);
            document.add(footer);

            document.close();

            String filename = "Test Result" + test.getSubject().getName() +
                    test.getTitle() +
                    LocalDate.now();

            openInBrowser(response, baos, filename);
        } catch (DocumentException | IOException e) {
            e.printStackTrace();
            //error-page
        }

    }

    private static void addEmptyLine(Paragraph paragraph, int number) {
        for (int i = 0; i < number; i++) {
            paragraph.add(new Paragraph(" "));
        }
    }

    private static void openInBrowser(HttpServletResponse response, ByteArrayOutputStream baos, String filename) {
        // setting some response headers
        response.setHeader("content-disposition", "filename=\"" + filename + '\"');
        response.setHeader("Expires", "0");
        response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
        response.setHeader("Pragma", "public");
        // setting the content type
        response.setContentType("application/pdf");
        // the content length
        response.setContentLength(baos.size());
        // write ByteArrayOutputStream to the ServletOutputStream
        OutputStream os = null;
        try {
            os = response.getOutputStream();
            baos.writeTo(os);
            os.flush();
            os.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}