# Canvas

To start your new Phoenix application you have to:

1. Install dependencies with `mix deps.get`
2. Start Phoenix router with `mix phoenix.start`

Now you can visit `localhost:4000` from your browser.


## Notes

* If you choose to change the application's structure, you could manually start the router from your code like this `Canvas.Router.start`

## Deploy

```
heroku apps:create [appname] --buildpack https://github.com/HashNuke/heroku-buildpack-elixir.git

# maybe
heroku config:set MIX_ENV=prod

git push heroku master
```

## TODO

* Add authentication
