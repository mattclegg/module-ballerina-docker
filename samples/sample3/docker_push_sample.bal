import ballerina.net.http;
import ballerinax.docker;

endpoint http:ServiceEndpoint helloWorldEP {
    port:9090
};
@docker:Config {
    push:true,
    registry:"index.docker.io/$env{DOCKER_USERNAME}",
    name:"helloworld-push",
    tag:"v2.0.0",
    username:"$env{DOCKER_USERNAME}",
    password:"$env{DOCKER_PASSWORD}"
}

@http:ServiceConfig {
      basePath:"/helloWorld"
}
service<http:Service> helloWorld bind helloWorldEP {
    sayHello (endpoint outboundEP, http:Request request) {
        http:Response response = {};
        response.setStringPayload("Hello, World from service helloWorld ! ");
        _ = outboundEP -> respond(response);
    }
}