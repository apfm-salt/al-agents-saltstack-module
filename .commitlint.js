const Configuration = {
    extends: ['@commitlint/config-conventional'],
    rules: {
	'footer-empty': [2, 'never'],
	'footer-link-issue': [2, 'always'],
    },
    plugins: [
	{
	    rules: {
		'footer-link-issue': ({footer}) => {
		    const issue_re = /(fix(e[sd])?|issue|relate[sd]?|resolve[sd]?|close[sd]?)\s+([a-z_-]+\/[a-z_-]+[#]|(gh-|[#]))\d+/ig;

		    return [issue_re.test(footer),
			'Your issue must link to a valid issue in the commit footer',
		    ];
		},
	    },
	}
    ],
};

module.exports = Configuration;
