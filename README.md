# buffer-scheduler
A daily job that tops up buffer

The script picks tweet contents from our contentful api using `hbs-content` and populates buffer with the tweets.

# Setup

```
git clone git@github.com:happybearsoftware/buffer-scheduler.git
cd buffer-scheduler

bundle install
```

Create a .env file to set environment variables as seen in .env.test

# Test

```
rspec
```

# Running the script

To run the script on your local environment, there are 2 options to being able to run the script.
- Option 1: Make the file executable
The script in `bin/schedule-tweets` already has a [shebang](http://www.catb.org/jargon/html/S/shebang.html) declaration to run it as a ruby file, so you can just make it an executable file.
```
chmod a+x bin/schedule-tweets
```

- Option 2: Using `-Ilib` command
If you want to be able to just run it without making it executable.

```
ruby -Ilib ./bin/schedule-tweets
```

On Heroku, because the file has a [shebang](http://www.catb.org/jargon/html/S/shebang.html), you can get the script running with `bin/schedule-tweets`