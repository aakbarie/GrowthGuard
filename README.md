# GrowthGuard

**GrowthGuard** is an interactive Shiny application designed to help parents and caregivers track their child's growth using personalized growth charts based on CDC-WHO standards. This user-friendly app allows you to input your child's height, weight, and other relevant data to generate detailed growth charts. The app is designed to be simple enough for anyone to use, with a focus on privacy and ease of access.

![GrowthGuard](https://github.com/yourusername/GrowthGuard/assets/banner.png) 

## Features

- **Personalized Growth Charts**: Create and view growth charts based on the child's data input, adjusted to CDC-WHO standards.
- **Easy Data Entry**: Input data using height in inches and weight in pounds; the app automatically converts these to centimeters and kilograms.
- **Download Options**: Easily download the growth data in CSV format and the generated chart as a PDF.
- **User Privacy**: The app does not store your data on servers, ensuring compliance with privacy and HIPAA regulations.

## App Preview

![App Screenshot](https://github.com/yourusername/GrowthGuard/assets/app_screenshot.png)

## Installation

To run the GrowthGuard app locally, follow these steps:

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/yourusername/GrowthGuard.git
   ```

2. **Navigate to the Project Directory:**

   ```bash
   cd GrowthGuard
   ```

3. **Install Required Packages:**

   Ensure you have R and RStudio installed. Then, install the required R packages using the following command:

   ```r
   # Install required packages
   install.packages(c("shiny", "shinydashboard", "shinyWidgets", "tidyverse", "lubridate"))
   ```

4. **Run the App:**

   Open `app.R` in RStudio and click "Run App" or use the command below in your R console:

   ```r
   shiny::runApp('path_to_your_app')
   ```

## Usage Guide

1. **Home Tab**: Provides an overview of the app and its functionality, including input expectations (height in inches and weight in pounds).
2. **Growth Chart Tab**:
   - Enter the child's name, sex, height, weight, date of birth, and date of visit.
   - Click "View Growth Chart" to generate a personalized growth chart.
   - Download the data and chart using the provided buttons for personal records.

## Screenshots

### Home Page

![Home Page](https://github.com/yourusername/GrowthGuard/assets/home_screenshot.png)

### Growth Chart Page

![Growth Chart](https://github.com/yourusername/GrowthGuard/assets/growth_chart_screenshot.png)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request or open an Issue for any feature requests or bug reports.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- **R Shiny**: A framework for building interactive web applications in R.
- **CDC-WHO Growth Standards**: The app utilizes growth standards provided by CDC and WHO for accurate growth tracking.

## Contact

For any questions or suggestions, please contact [Akbar](mailto:akbar.esfahani@gmail.com).

---

**GrowthGuard** - Helping caregivers track growth, one chart at a time.
