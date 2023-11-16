pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                // Étape de récupération des sources du dépôt GitHub
                checkout scm
            }
        }
        stage('Build') {
            parallel {
                stage('Generate Site') {
                    steps {
                        // Étape de génération du site statique
                        sh 'pandoc -s index.md --template _template_.html -o index.html'
                    }
                }
                stage('Generate DOCX') {
                    steps {
                        // Étape de génération du fichier DOCX
                        sh 'pandoc -s index.md -o index.docx'
                    }
                }
            }
        }
        stage('Archive') {
            steps {
                // Archiver les fichiers générés
                archiveArtifacts artifacts: '*.html, *.docx', allowEmptyArchive: true
            }
        }
    }
}
