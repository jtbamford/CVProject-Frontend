package com.qa.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
public class SpringSecurityConfig extends WebSecurityConfigurerAdapter {
	@Autowired
	DataSource dataSource;
	
	@Autowired
	PasswordEncoder passwordEncoder;

    public SpringSecurityConfig() {
        super();
    }
    
    @Autowired
    public void configAuthentication(AuthenticationManagerBuilder auth) throws Exception {
      auth.jdbcAuthentication().dataSource(dataSource).passwordEncoder(passwordEncoder)
     .usersByUsernameQuery("select username,password, enabled from users where username=?")
     .authoritiesByUsernameQuery("select username, role from users where username=?");
    } 


    @Override
    protected void configure(final HttpSecurity http) throws Exception {
        http
        .csrf().disable()
        .authorizeRequests()
        	.antMatchers("/register").permitAll()
        	.antMatchers("/trainingmanager/**").access("hasRole('ROLE_TRAINING_MANAGER')")
        	.antMatchers("/trainer/**").access("hasRole('ROLE_TRAINER')")
        	.antMatchers("/trainee/**").access("hasRole('ROLE_TRAINEE')")
        	
        	.antMatchers("/anonymous*").anonymous()
        	//.antMatchers(HttpMethod.GET, "/index*", "/static/**", "/*.js", "/*.json", "/*.ico").permitAll()
        	.anyRequest().authenticated()
        .and()
        	.formLogin()
        	.loginPage("/login").permitAll()
        	.loginProcessingUrl("/perform_login")
        	.defaultSuccessUrl("/homepage",true)
        	.failureUrl("/login?error=true")
        .and()
        	.logout()
        	.logoutUrl("/perform_logout")
        	.deleteCookies("JSESSIONID")
        .and()
    		.exceptionHandling()
    		.accessDeniedPage("/accessDenied");
    }

	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/*.css");
		web.ignoring().antMatchers("/*.js");
	}
}