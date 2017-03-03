package com.github.todo.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import com.github.todo.interceptor.LoginCheckInterceptor;

@Configuration
public class WebMvcConfiguration extends WebMvcConfigurerAdapter {
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new LoginCheckInterceptor()).excludePathPatterns("/user/create", "/login/form",
				"/login/submit", "/login/signup", "/user/validate");
	}

	@Override
	public void addViewControllers(ViewControllerRegistry registry) {

	}
}