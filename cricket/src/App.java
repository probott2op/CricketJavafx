import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.*;
import javafx.stage.Stage;
import java.sql.*;

public class App extends Application {

    private Connection connection;

    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) {
        primaryStage.setTitle("Cricket Database Management");

        // Initialize database connection
        connectToDatabase();

        // Main layout
        VBox mainLayout = new VBox(10);
        mainLayout.setPadding(new Insets(20));

        // Buttons for adding data
        Button addTeamButton = new Button("Add Team");
        Button addPlayerButton = new Button("Add Player");
        Button addMatchButton = new Button("Add Match");
        Button addScoreButton = new Button("Add Score");

        // Buttons for viewing stats
        Button viewPlayerStatsButton = new Button("View Player Stats");
        Button viewTeamStatsButton = new Button("View Team Stats");

        // Add buttons to the layout
        mainLayout.getChildren().addAll(addTeamButton, addPlayerButton, addMatchButton, addScoreButton,
                viewPlayerStatsButton, viewTeamStatsButton);

        // Set actions for buttons
        addTeamButton.setOnAction(e -> showAddTeamDialog());
        addPlayerButton.setOnAction(e -> showAddPlayerDialog());
        addMatchButton.setOnAction(e -> showAddMatchDialog());
        addScoreButton.setOnAction(e -> showAddScoreDialog());
        viewPlayerStatsButton.setOnAction(e -> showPlayerStatsDialog());
        viewTeamStatsButton.setOnAction(e -> showTeamStatsDialog());

        // Scene setup
        Scene scene = new Scene(mainLayout, 400, 300);
        scene.getStylesheets().add("styles.css"); // Link CSS file
        primaryStage.setScene(scene);
        primaryStage.show();
    }

    private void connectToDatabase() {
        try {
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cricket", "root", "password");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void showAddTeamDialog() {
        // Implement dialog to add a team
    }

    private void showAddPlayerDialog() {
        // Implement dialog to add a player
    }

    private void showAddMatchDialog() {
        // Implement dialog to add a match
    }

    private void showAddScoreDialog() {
        // Implement dialog to add a score
    }

    private void showPlayerStatsDialog() {
        Dialog<String> dialog = new Dialog<>();
        dialog.setTitle("View Player Stats");

        // Set the button types
        ButtonType searchButtonType = new ButtonType("Search", ButtonBar.ButtonData.OK_DONE);
        dialog.getDialogPane().getButtonTypes().addAll(searchButtonType, ButtonType.CANCEL);

        // Create the player name input
        GridPane grid = new GridPane();
        grid.setHgap(10);
        grid.setVgap(10);
        grid.setPadding(new Insets(20, 150, 10, 10));

        TextField playerNameField = new TextField();
        playerNameField.setPromptText("Player Name");

        grid.add(new Label("Player Name:"), 0, 0);
        grid.add(playerNameField, 1, 0);

        dialog.getDialogPane().setContent(grid);

        // Result handling
        dialog.setResultConverter(dialogButton -> {
            if (dialogButton == searchButtonType) {
                return playerNameField.getText();
            }
            return null;
        });

        dialog.showAndWait().ifPresent(playerName -> {
            try {
                String query = "SELECT p.first_name, p.last_name, t.team_name, s.runs, s.wickets, m.match_date, m.venue " +
                        "FROM players p " +
                        "JOIN teams t ON p.team_id = t.team_id " +
                        "JOIN scores s ON p.player_id = s.player_id " +
                        "JOIN matches m ON s.match_id = m.match_id " +
                        "WHERE CONCAT(p.first_name, ' ', p.last_name) = ?";
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setString(1, playerName);
                ResultSet rs = ps.executeQuery();

                StringBuilder stats = new StringBuilder();
                while (rs.next()) {
                    stats.append("Name: ").append(rs.getString("first_name")).append(" ").append(rs.getString("last_name")).append("\n")
                            .append("Team: ").append(rs.getString("team_name")).append("\n")
                            .append("Runs: ").append(rs.getInt("runs")).append("\n")
                            .append("Wickets: ").append(rs.getInt("wickets")).append("\n")
                            .append("Match Date: ").append(rs.getDate("match_date")).append("\n")
                            .append("Venue: ").append(rs.getString("venue")).append("\n\n");
                }

                Alert alert = new Alert(Alert.AlertType.INFORMATION);
                alert.setTitle("Player Stats");
                alert.setHeaderText(null);
                alert.setContentText(stats.toString());
                alert.showAndWait();

            } catch (SQLException e) {
                e.printStackTrace();
            }
        });
    }

    private void showTeamStatsDialog() {
        Dialog<String> dialog = new Dialog<>();
        dialog.setTitle("View Team Stats");

        // Set the button types
        ButtonType searchButtonType = new ButtonType("Search", ButtonBar.ButtonData.OK_DONE);
        dialog.getDialogPane().getButtonTypes().addAll(searchButtonType, ButtonType.CANCEL);

        // Create the team name input
        GridPane grid = new GridPane();
        grid.setHgap(10);
        grid.setVgap(10);
        grid.setPadding(new Insets(20, 150, 10, 10));

        TextField teamNameField = new TextField();
        teamNameField.setPromptText("Team Name");

        grid.add(new Label("Team Name:"), 0, 0);
        grid.add(teamNameField, 1, 0);

        dialog.getDialogPane().setContent(grid);

        // Result handling
        dialog.setResultConverter(dialogButton -> {
            if (dialogButton == searchButtonType) {
                return teamNameField.getText();
            }
            return null;
        });

        dialog.showAndWait().ifPresent(teamName -> {
            try {
                String query = "SELECT m.match_date, m.venue, m.result, t1.team_name AS team1, t2.team_name AS team2 " +
                        "FROM matches m " +
                        "JOIN teams t1 ON m.team1_id = t1.team_id " +
                        "JOIN teams t2 ON m.team2_id = t2.team_id " +
                        "WHERE t1.team_name = ? OR t2.team_name = ?";
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setString(1, teamName);
                ps.setString(2, teamName);
                ResultSet rs = ps.executeQuery();

                StringBuilder stats = new StringBuilder();
                int win = 0, lose = 0, draw = 0;
                while (rs.next()) {
                    stats.append("Match Date: ").append(rs.getDate("match_date")).append("\n")
                            .append("Venue: ").append(rs.getString("venue")).append("\n")
                            .append("Teams: ").append(rs.getString("team1")).append(" vs ").append(rs.getString("team2")).append("\n")
                            .append("Result: ").append(rs.getString("result")).append("\n\n");

                    if (rs.getString("result").contains("won")) {
                        if (rs.getString("result").contains(teamName)) {
                            win++;
                        } else {
                            lose++;
                        }
                    } else {
                        draw++;
                    }
                }

                stats.append("Win: ").append(win).append("\n")
                        .append("Lose: ").append(lose).append("\n")
                        .append("Draw: ").append(draw).append("\n");

                Alert alert = new Alert(Alert.AlertType.INFORMATION);
                alert.setTitle("Team Stats");
                alert.setHeaderText(null);
                alert.setContentText(stats.toString());
                alert.showAndWait();

            } catch (SQLException e) {
                e.printStackTrace();
            }
        });
    }
}