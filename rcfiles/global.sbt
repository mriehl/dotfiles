import org.ensime.EnsimeCoursierKeys._
import org.ensime.EnsimeKeys._
ensimeJavaFlags in ThisBuild := Seq("-Xss2m", "-Xmx4g", "-XX:MaxMetaspaceSize=512m", "-XX:+UseG1GC")

ensimeScalaVersion in ThisBuild := "2.12.3"
