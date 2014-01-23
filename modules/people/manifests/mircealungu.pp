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

	package { 'Pomodoro Desktop':
    	source   => 'http://download2us.softpedia.com/dl/3ead7e7096947241e044e6b404084eb3/52e05b40/400057530/mac/Business/pomodoro-0.31.zip',
    	provider => compressed_app
  	}

  	package { 'WebStorm':
    	ensure => installed,
    	source => 'http://download.jetbrains.com/webstorm/WebStorm_7.0.3.dmg',
    	provider => appdmg,
  	}

  	package { 'PyCharm':
    	ensure => installed,
    	source => 'http://download.jetbrains.com/python/pycharm-professional-3.0.2.dmg',
    	provider => appdmg,
  	}

  	

  	

  	



}
