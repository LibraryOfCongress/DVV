import ch.qos.logback.classic.encoder.PatternLayoutEncoder
import ch.qos.logback.core.ConsoleAppender
import ch.qos.logback.core.FileAppender

import static ch.qos.logback.classic.Level.*

appender("STDOUT", ConsoleAppender) {
  encoder(PatternLayoutEncoder) {
    pattern = "%d{HH:mm:ss.SSS} - %msg%n"
  }
}

def bySecond = timestamp("yyyy-MM-dd-HHmm")

appender("FILEOUT", FileAppender) {
  append = false
  file = "${System.getProperty("app.home")}/logs/validation-processor-${bySecond}.log"
  encoder(PatternLayoutEncoder) {
    pattern = "%date %level [%thread] %logger{10} [%file:%line] %msg%n"
  }
}
root(WARN, ["STDOUT", "FILEOUT"])
//Change INFO to DEBUG for more verbose output
logger("gov.loc.repository", INFO)
logger("gov.loc.ndnp", INFO)