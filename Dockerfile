FROM python:3.10

# Installing dependencies for running a python application 
RUN apt-get update && apt-get install -y python3 python3-pip postgresql-client libpq-dev 

# Install pipenv 
RUN pip3 install pipenv 

# Setting the working directory 
WORKDIR /app 

# Install pipenv dependencies 
COPY Pipfile Pipfile.lock ./ 
RUN pipenv update && pipenv install --system --deploy

# Copying our application into the container 
COPY todo todo 

# Running our application 
# Adding a delay to our application startup 
CMD ["sleep", "10", "&&", "flask", "--app", "todo", "run", "--host", "0.0.0.0", "--port", "6400"]