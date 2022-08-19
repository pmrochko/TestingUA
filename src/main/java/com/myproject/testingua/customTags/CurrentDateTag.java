package com.myproject.testingua.customTags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

public class CurrentDateTag extends SimpleTagSupport {
    StringWriter body = new StringWriter();

    @Override
    public void doTag() throws JspException, IOException {
        getJspBody().invoke(body);
        JspWriter out = getJspContext().getOut();
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        String currentDate = dateFormat.format(new Date());
        out.print(body.toString() + ' ' + currentDate);
    }
}