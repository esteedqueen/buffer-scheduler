# buffer-scheduler
A daily job that tops up buffer

The script picks tweet contents from our contentful api using `hbs-content` and populates buffer with the tweets.

# Setup

```
git clone git@github.com:esteedqueen/buffer-scheduler.git
cd buffer-scheduler

bundle install
```

Create a .env file to set environment variables as seen in .env.test

```
cp .env.test .env
```

# Test

```
rspec
```

# Running the script

```
bin/schedule-tweets
```