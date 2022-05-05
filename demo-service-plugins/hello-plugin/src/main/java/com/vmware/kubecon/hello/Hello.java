package com.vmware.kubecon.hello;

import lombok.extern.slf4j.Slf4j;

/**
 * Plugin body.
 */
@Slf4j
public class Hello {

  /**
   * Main constructor.
   */
  public Hello() {

  }

  /**
   * Friendly salute.
   */
  public void salute() {
    log.info("Hi KubeCon!");
  }
}
