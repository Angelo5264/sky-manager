
import org.mindrot.jbcrypt.BCrypt;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author maick
 */
public class TestDB {

    public static void main(String[] args) {
        String password = "123456";  // Tu nueva contraseña
        String hash = BCrypt.hashpw(password, BCrypt.gensalt(12));
        System.out.println("Nuevo hash: " + hash);
    }
}
