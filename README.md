Алгоритм:
0. Настройка на локальном ноуте terraform, утилиты yc, docker descktop, vsc
1. Создал конфигурационный файл default.tf с яндекс RP
2. Инициализация рабочей директории, где хранятся конфигурационные файлы командой:
> terraform init

3. Создал оснвоной деплоймент файл kubernetes-cluster.tf. В нём описано:
  1. Создал мастер-узел кластера k8s в одной зоне, с внешним IP
  2. Создал один рабочий узел
  3. Ресурс провайдеры с сервисной УЗ, ролями на публичный IP, ALB, image.puller
  4. Сервисную группу безопасности
> terraform apply

4. Создание container registry
> yc container registry create --name lab-demo

5. После установки K8S надо настроить подключение через CLI
> yc managed-kubernetes cluster get-credentials --id cat8g2scs4e8i6g9*** --external

6. Подготовил директорию с приложением. Приложение показывает одну страницу (файл app.py), рядом Dockerfile. 
> docker build - собирает образ, проверяем доступность образа через docker desktop
> docker push cr.yandex/crpc8jkq8ef0862s****/lab-demo2:v1 - образ публикуется в container registry

7. Проверяю, что мастер у рабочий узел поднялись. Через Marketplace устанавливаю Ingress Application Load Balancer - L7.

8. В yaml файле описал создание одного deploymenta для запуска приложения из образа в CR, одного сервиса с типом NodePort.
>kubectl apply -f app.yaml
9. В yaml файле описал создание Ingress, описал пути /app1 - сервис alb-demo-1, /app2 - сервис alb-demo-2 
>kubectl apply -f ingress.yaml

Как итог - балансировщик создался, внешний IP выдался, роутер, бэкэнды и группы настроились, а доступа к приложению по IP нет.
При этом:
1. Если создать сервис с типом LoadBalancer (l4), то выделяется внешний IP и доступ до приложения по IP есть
2. Если сделать форвард трафика на локальный хост, то приложение тоже открывается http://locahhost:80
> kubectl port-forward service/alb-demo-2 30082:80 --namespace default
3. В случае с ingress controller приложение не открывается

Чуть больше времени появится на дебаг - продолжу и донастрою конфигурацию.
