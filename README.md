# **Docker setup for local development**
A pretty simplified Docker Compose setup for local Laravel development with HTTPS using mkcert.

## **Content**
This repo creates a basic LEMP stack with some extra services. 
The complete list of the services with the exposed ports:

- **nginx** :80 | :443  
- **mysql** :3306
- **php** :9000
- **redis** :6379
- **npm** :3000 | :3001
- **mailhog** :1025 | :8025
- **phpmyadmin** :8080 

## **Directions of Use**
**1. Clone Repository:**
```bash
git clone git@github.com:shinzoke/docker_local-development_mkcert.git && cd docker_local-development_mkcert
```

**2. Create mkcert certificate at nginx/certs directory:**
```bash
cd nginx/certs && mkcert app.test && cd ../../
```

**3. Add app.test to your machine's host file:**
```
127.0.0.1 app.test
```

**4. Spin up the containers:**
```bash
docker compose up -d --build app
```

**5. Create new Laravel Project:**
```bash
docker compose run --rm php composer create-project laravel/laravel .
```

## **Info**
Bringing up the Docker Compose network with `--build app` instead of just using `up`, ensures that only our app's containers are brought up at the start, instead of all of the command containers as well. 
The following containers are built for our web server.

Use the following command examples from your project root, modifying them to fit your particular use case.
The Compose and 

- `docker compose run --rm php composer`
- `docker compose run --rm npm`
- `docker compose run --rm php php artisan` 

### MySQL Storage
By default the MySQL data is stored inside the mysql directory that will be created the first time you spin up your project.
In case you would like to have your data deleted everytime you bring down your project containers:

1. Make sure your project containers are down.
   - (Optional) Delete the `mysql` directory in your project root in case you already started your containers.
2. Under the mysql service in your `docker-compose.yml` delete the following lines:

```
volumes:
  - ./mysql:/var/lib/mysql
```

### Using BrowserSync with Laravel Mix

If you want to enable the hot-reloading that comes with Laravel Mix's BrowserSync option, add the following to the end of your Laravel project's `webpack.mix.js` file:

```javascript
.browserSync({
    proxy: 'app',
    open: false,
    port: 3000,
});
```

From your terminal window at the project root, run the following command to start watching for changes with the npm container and its mapped ports:

```bash
docker compose run --rm --service-ports npm run watch
```

That should keep a small info pane open in your terminal (which you can exit with Ctrl + C). Visiting [localhost:3000](http://localhost:3000) in your browser should then load up your Laravel application with BrowserSync enabled and hot-reloading active.


## Credits
This is a rework from the [original repo](https://github.com/aschmelyun/docker-compose-laravel) created by [aschmelyun](https://github.com/aschmelyun).
