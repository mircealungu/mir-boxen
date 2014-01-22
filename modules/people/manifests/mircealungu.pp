class people::mircealungu {
	
	include osx::dock::autohide
	include osx::universal_access::ctrl_mod_zoom



	$my_homedir = '/Users/mircea'

	notify { 'class mircealungu declared.': }

	repository { 
		"/Users/mircea/scripts":
    	source => 'mircealungu/scripts',
    }

    # make sure that we load the profile from scripts
	file_line { 'personalized_profile_rule':
	   path => '/Users/mircea/.profile',
	   line => 'source scripts/profile',
	}

	package { 'Github for Mac':
    	source   => 'https://github-central.s3.amazonaws.com/mac%2FGitHub%20for%20Mac%20124.zip',
    	provider => compressed_app
  	}



}
