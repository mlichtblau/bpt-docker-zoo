events {
    worker_connections 768;
}
http {
    map $http_upgrade $connection_upgrade {
        default upgrade;
        '' close;
    }

    server {
        rewrite ^$DEPLOY_PATH/$CHIMERA_DEPLOY_NAME$ $scheme://$http_host$DEPLOY_PATH/$CHIMERA_DEPLOY_NAME/ permanent;
        location $DEPLOY_PATH/$CHIMERA_DEPLOY_NAME/ {
            proxy_pass http://chimera:8080/$CHIMERA_DEPLOY_NAME/;
        }

        rewrite ^$DEPLOY_PATH/$UNICORN_DEPLOY_NAME$ $scheme://$http_host$DEPLOY_PATH/$UNICORN_DEPLOY_NAME/ permanent;
        location $DEPLOY_PATH/$UNICORN_DEPLOY_NAME/ {
            proxy_pass http://unicorn:8080/$UNICORN_DEPLOY_NAME/;
        }

        rewrite ^$DEPLOY_PATH/$GRYPHON_DEPLOY_NAME$ $scheme://$http_host$DEPLOY_PATH/$GRYPHON_DEPLOY_NAME/ permanent;
        location $DEPLOY_PATH/$GRYPHON_DEPLOY_NAME/ {
            proxy_pass http://gryphon:3000/;
        }
    }
}
