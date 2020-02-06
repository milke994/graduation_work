package com.milic.config;

import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@Configuration
@EnableJpaAuditing
@EnableJpaRepositories(basePackages = {"com.milic.db.repositories"})
@EntityScan({"com.milic.db.model"})
public class JpaConfig {
  // Keep empty. this is just for the annotations.
}

