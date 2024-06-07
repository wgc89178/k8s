pipeline {
    // 指定任务在哪个集群节点中执行，any表示任意节点
    agent any
    
        // 声明全局变量，方便后面修改使用
    environment {
                        
        // 源jar名称，mvn打包之后，target目录下的jar包名称
        JAR_NAME='main*'

        // jenkins下的目录
        JENKINS_HOME='/root/.jenkins/workspace/t01'
    }

    
    stages {
        stage('拉取代码') {
            steps {
                // 清除工作空间
                deleteDir()
                // 拉取代码 gitTag 是 之前自定义的 字符串参数
		checkout([$class: 'GitSCM', branches: [[name: '${tag}']], extensions: [], userRemoteConfigs: [[credentialsId: 'efcb36ce-ecda-45b3-b749-f0b66ec0b9ac', url: 'https://github.com/wgc89178/k8s.git']]])
                echo '拉取成功'
            }
        }
        
        stage('执行构建') {
            steps {
            //    sh "mvn --version"
		sh '''
			cd $JENKINS_HOME
			docker build -t 172.26.240.210:80/repo/nginx:1.20.1 .
　　　　　　　　　　	docker login -u wgc89178 -p Harbor12345 172.26.240.210:80
　　　　　　　　　　　　docker push 172.26.240.210:80/repo/nginx:1.20.1'''
                echo '构建完成'
            }
        }
        
        stage('把jar包构建为docker镜像并运行') {
            steps {
                sh '''#!/bin/bash
                        
                        # 这个点（.）就是指的本目录下的 Dockerfile 文件，而
                        #echo "打包镜像"
                        #docker build -t $name:$tag .
                        
                        echo "运行镜像"
                        docker run -d -p 9999:80 --name nginx_test 172.26.240.210:80/repo/nginx:1.20.1
                '''
                echo '运行成功'
            }
        }
    }
}

