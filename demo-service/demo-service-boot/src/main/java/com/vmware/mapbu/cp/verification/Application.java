package com.vmware.kubecon;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.flyway.FlywayAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;
import org.springframework.context.annotation.Configuration;

/**
 * Main class for Spring Boot application.
 */
@Configuration
@SpringBootApplication(scanBasePackages = "com.vmware.kubecon", exclude = {
    DataSourceAutoConfiguration.class, HibernateJpaAutoConfiguration.class, FlywayAutoConfiguration.class})
public class Application {

  /**
   * Main method.
   */
  public static void main(String[] args) {
    SpringApplication.run(Application.class, args);
  }
}
