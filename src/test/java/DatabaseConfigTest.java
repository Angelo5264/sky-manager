

import java.sql.Connection;
import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import org.junit.jupiter.api.Test;

import com.skymanager.config.DatabaseConfig;

public class DatabaseConfigTest {
 
    @Test
    public void coneccionDatabase() throws SQLException{
        DatabaseConfig dt = DatabaseConfig.getInstance();
        Connection con = dt.getConnection();
        
        assertNotNull(con);
        
    }
    
}
