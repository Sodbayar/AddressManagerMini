<%@ page contentType="text/html;charset=utf-8"
import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"
import="java.util.*, java.io.*"
%>
<%
 request.setCharacterEncoding("utf-8");

int maxsize = 5*1024*1024;//최대 업로드 파일 크기 : 5Mb

//upload 이름을 가지는 실제 서버의 경로명 알아내기
ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");


out.println("서버의 upload 실제 경로 : " + realFolder + "<HR>");

try {
	MultipartRequest m = new MultipartRequest(request, realFolder, maxsize, "utf-8", new DefaultFileRenamePolicy());
	Enumeration<?> params = m.getParameterNames();
	
	while (params.hasMoreElements()) {
		String name = (String) params.nextElement();
		String value = m.getParameter(name);
		out.println(name + " = " + value + "<br>");
	}
	out.println("<HR>");
	
	Enumeration<?> fileParams = m.getFileNames();
	while(fileParams.hasMoreElements() ) {
	String name = (String) fileParams.nextElement();
	out.println("&lt;input type=file&gt;인 name값 : " + name);
	}

	out.println("<HR>");

	String fileName = m.getFilesystemName("fileName");
	//서버에 저장된 파일 이름
	String orgName = m.getOriginalFileName("fileName");


	String typeFile = m.getContentType("fileName");
	
	File file = m.getFile("fileName");
%>

서버에 저장된 파일 이름 : <%= fileName %><BR>
전송전 원래 파일 이름 : <%= orgName %><BR>
파일 타입 : <%= typeFile %><BR>
파일 크기 : <%= file.length() %> bytes<BR>
<%
} catch(IOException e) {
	out.println("파일 전송 오류 : " + e);
}
%>

