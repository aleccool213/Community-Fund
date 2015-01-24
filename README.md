# csc309project
Course project for csc309

## To get up and running
1. Install a good editor. I use Sublime but, you know, diff'rent strokes for diff'rent people
2. Install a good terminal. I use iterm2, running zsh with [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) to make it look pretty
3. Clone the repo and cd into the project folder
4. Run `bundle install --without production` in order to install all needed gems
5. Run `rake db:migrate` to create a database. It should be defaulting on sqlite but we can totally change this later and re-run all the migrations
6. Run `rails s` to start this puppy
