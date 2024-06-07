pipeline {
    // jenkins集群中的任一节点
    agent any

    // 存放所有任务集合
    stages {
        stage("拉取Git代码") {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '${tag}']], extensions: [], userRemoteConfigs: [[credentialsId: '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', url: 'https://github.com/wgc89178/k8s.git']]])
            }
        }

        stage("制作自定义镜像并且发布到Harbor") {
            steps {
                sh '''docker build -t 172.26.240.210:80/repo/${JOB_NAME}:$tag .
　　　　　　　　　　docker login -u wgc89178 -p Harbor12345 172.26.240.210:80
　　　　　　　　　　　　docker push 172.26.240.210:80/repo/${JOB_NAME}:$tag'''
            }
        }

        stage("通知远程服务器拉取镜像，进行部署") {
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'server02', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''cd /usr/local/test
　　　　　　　　　　chmod a+x deploy.sh
　　　　　　　　　　./deploy.sh 172.26.240.210:80 repo ${JOB_NAME} $tag $host_port $container_port''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: 'deploy.sh')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }

    }
}
