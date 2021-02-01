<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */
// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );
/** MySQL database username */
define( 'DB_USER', 'root' );
/** MySQL database password */
define( 'DB_PASSWORD', 'root' );
/** MySQL hostname */
define( 'DB_HOST', 'mysql-service:3306' );
/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );
/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );
/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '8;inDLy;J?Uo}{%@o`|fVjc(XV]CO`{^Bi64Lk2j.OuoP^5Z]at.bRng<4*a(U4X');
	define('SECURE_AUTH_KEY',  ',p;.c~>-P @hI:(|w @|TW`[Ey~PU?[DIm>r<N*[1B|VT!{|M+;-M~QhXb[^#Us-');
	define('LOGGED_IN_KEY',    '(J[&_4-b[U+XTSWZfJ+S,BJpdNh:sL/|qC4rP+_[>LI:8!ezLwG]F}o=wB;UL}Vx');
	define('NONCE_KEY',        'l[b*4y7qNv$nmnTP$9id~[--85zs?oOM-IR!^/v+eOz<nhc_A m3m!Kb:b+J]x|%');
	define('AUTH_SALT',        '4yl@2V[d7FeF:Kui]_{;Jctx&ozs<c5&&GDfWsrmV.Io1u!`D>p60>XXvQcf8-g{');
	define('SECURE_AUTH_SALT', '0J<;o_-7JpRP +A|E5E%QtErP_o` e4$B6~t`--z m!@hMEo^d<uhg+MA$m.S,>f');
	define('LOGGED_IN_SALT',   'gfter+Bj+-q VhZ6N, 2`K>P+n;!Lk>q^yX$rnk+Nw9p~%X%_MkW@ehX+tP7zuhV');
	define('NONCE_SALT',       'J;`D]Gz~?BHR7|V5,ZtRuE#U_oWS/r(sG+t(.i`<L1l[1%(gb!h2UGX#.O|InHK+');
/**#@-*/
/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';
/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', true );
/* That's all, stop editing! Happy publishing. */
/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
