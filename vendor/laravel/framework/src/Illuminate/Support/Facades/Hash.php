<?php namespace Illuminate\Support\Facades;

class Hash extends Facade {

	/**
	 * Get the registered name of the component.
	 *
	 * @return string
	 */
	protected static function getFacadeAccessor() { return 'hash'; }

    private static $encryptKey = 'directsponsor';

    public static function setEncryptKey($key){
        Hash::$encryptKey = $key;
    }

    public static function iv(){
        return md5(md5(Hash::$encryptKey));
    }

    public static function encrypt($string){
        $output = false;
        $iv = Hash::iv();
        $output = mcrypt_encrypt(MCRYPT_RIJNDAEL_256, md5(Hash::$encryptKey), $string, MCRYPT_MODE_CBC, $iv);
        $output = base64_encode($output);
        $output = str_replace('/', '*', $output);
        return $output;
    }

    public static function decrypt($string){
        $output = false;
        $iv = Hash::iv();
        $output = str_replace('*', '/', $string);
        $output = base64_decode($output);
        $output = mcrypt_decrypt(MCRYPT_RIJNDAEL_256, md5(Hash::$encryptKey), $output, MCRYPT_MODE_CBC, $iv);
        $output = rtrim($output);
        return $output;
    }
}