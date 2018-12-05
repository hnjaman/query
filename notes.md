## REST
RESTful web application enables the client to take actions on server resources, 
such as create new resources (i.e. create a new user) or 
change existing resources (i.e. edit a post).
###  Idempotent
clients can make that same call repeatedly while producing the same result.
POST -> Not Idempotent, Otherwise all are Idempotent
Both PUT and POST can be used for creating. 
REST 6 constraints
https://medium.com/extend/what-is-rest-a-simple-explanation-for-beginners-part-2-rest-constraints-129a4b69a582

## DI 
Constructor injection (the good) -> for mandatory feild
Setter injection (the ugly) 		-> for optional feild, Setter Injection Make Testing Easy
Field injection (the bad)	-> head to use outside of spring container, Field Injection, a Unit Test Dies

@Configuration -> indicates that the class can be used by the Spring IoC container 
				  as a source of bean definitions.
@Bean -> annotation tells Spring that a method annotated with @Bean will return an object
		that should be registered as a bean in the Spring application context