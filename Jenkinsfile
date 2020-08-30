pipeline {
environment {
registry = "pratiksham05/hello-pipeline"
registryCredential = 'dockerhub_id'
dockerImage = ''
}
agent any
stages {
stage('Cloning our Git') {
steps {
git 'https://github.com/pratiksha05/Pratikshagithub_jenkins.git'
}
}
stage('Building our image') {
steps{
script {
dockerImage = docker.build registry + ":$BUILD_NUMBER"
}
}
}
stage('Deploy our image') {
steps{
script {
docker.withRegistry( '', registryCredential ) {
dockerImage.push()
}
}
}
}
stage('Cleaning up') {
steps{
sh "docker rmi $registry:$BUILD_NUMBER"
}
}
stage('Deployment') {
parallel {
stage('Staging') {
when {
branch 'staging'
}
steps {
withAWS(region:'<your-bucket-region>',credentials:'<AWS-Staging-Jenkins-Credential-ID>') {
  s3Delete(bucket: '<bucket-name>', path:'**/*')
  s3Upload(bucket: '<bucket-name>', workingDir:'build', includePathPattern:'**/*');
}
mail(subject: 'Staging Build', body: 'New Deployment to Staging', to: 'jenkins-mailing-list@mail.com')
}
}
stage('Production') {
when {
branch 'master'
}
steps {
withAWS(region:'<your-bucket-region>',credentials:'<AWS-Production-Jenkins-Credential-ID>') {
  s3Delete(bucket: '<bucket-name>', path:'**/*')
  s3Upload(bucket: '<bucket-name>', workingDir:'build', includePathPattern:'**/*');
}
mail(subject: 'Production Build', body: 'New Deployment to Production', to: 'jenkins-mailing-list@mail.com')
}
}
}
}
}
}





