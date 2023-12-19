# mistral_vllm_demo
This demo includes a container for generating product descriptions using Mistral 7B Instruct model served using vLLM. 

1. Build the Docker image
   docker build --rm --platform linux/amd64 -t mistral .
                             
3. Tag and push it to Snowpark container services image repo
   docker tag mistral sfsenorthamerica-polaris2.registry.snowflakecomputing.com/mistral_vllm_db/public/images/mistral
   docker push sfsenorthamerica-polaris2.registry.snowflakecomputing.com/mistral_vllm_db/public/images/mistral
   
5. Push the spec.yaml @yamls stage.
   use database MISTRAL_VLLM_DB;
   put file:///Users/ejohnson/git/mistral-vllm/spec.yaml @yamls overwrite=true auto_compress=false;
