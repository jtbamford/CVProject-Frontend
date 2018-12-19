package com.qa.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@Configuration
public class WebConfig extends WebMvcConfigurerAdapter {

	public WebConfig() {
        super();
    }

	
    @Override
    public void addResourceHandlers(final ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/*.js/**").addResourceLocations("/ui/static/");
        registry.addResourceHandler("/*.css/**").addResourceLocations("/ui/static/");
    }
    
    @Override
    public void addViewControllers(final ViewControllerRegistry registry) {
        super.addViewControllers(registry);

        registry.addViewController("/anonymous");
        registry.addViewController("/login");
        registry.addViewController("/register");
        registry.addViewController("/homepage");
       
        registry.addViewController("/trainingmanager/adminpage");
        registry.addViewController("/trainingmanager/CV");
        registry.addViewController("/trainingmanager/trainees/edittrainees");
        registry.addViewController("/trainingmanager/trainees/addtrainees");
        registry.addViewController("/trainingmanager/trainees/viewtrainees");
        registry.addViewController("/trainingmanager/trainers/edittrainers");
        registry.addViewController("/trainingmanager/trainers/addtrainers");
        registry.addViewController("/trainingmanager/trainers/viewtrainers");
        
        registry.addViewController("/trainer/CV");
        registry.addViewController("/trainer/viewtrainees");
        registry.addViewController("/trainer/trainerpage");
        
        
        registry.addViewController("/trainee/account");
        registry.addViewController("/trainee/CV");    
        
        registry.addViewController("/accessDenied");
    }
    
    @Bean
    public InternalResourceViewResolver setupViewResolver()  {
        InternalResourceViewResolver resolver =  new InternalResourceViewResolver();
        resolver.setPrefix ("/ui/jsp/");
        resolver.setSuffix (".jsp");
        resolver.setViewClass (JstlView.class);
        return resolver;
    }
    
    @Bean(name = "dataSource")
    public DriverManagerDataSource dataSource() {
        DriverManagerDataSource driverManagerDataSource = new DriverManagerDataSource();
        driverManagerDataSource.setDriverClassName("com.mysql.jdbc.Driver");
        driverManagerDataSource.setUrl("jdbc:mysql://localhost:3306/userbd");
        driverManagerDataSource.setUsername("root");
        driverManagerDataSource.setPassword("password");
        return driverManagerDataSource;
    }
    
    
    
    @Bean
	public PasswordEncoder passwordEncoder(){
		return new BCryptPasswordEncoder();
	}

}
