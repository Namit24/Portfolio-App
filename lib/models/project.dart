class Project {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String? githubUrl;
  final String? liveUrl;
  final String? detailedDescription;
  final List<String>? features;
  final List<String>? screenshots;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    this.githubUrl,
    this.liveUrl,
    this.detailedDescription,
    this.features,
    this.screenshots,
  });

  static List<Project> sampleProjects = [
    Project(
      id: "women-safety",
      title: "Women Safety App",
      description: "A mobile application designed to enhance women's safety with emergency features and location tracking.",
      imageUrl: "assets/images/women_safety_app.png",
      technologies: ["Flutter", "Firebase", "Google Maps API", "Geolocation"],
      githubUrl: "https://github.com/Namit24/Women-Safety",
      detailedDescription: 
        "The Women Safety App is designed to provide immediate assistance in emergency situations. "
        "It features one-tap SOS alerts, real-time location sharing with trusted contacts, and "
        "integration with emergency services. The app also includes safety tips and resources for users.",
      features: [
        "One-tap SOS emergency alert system",
        "Real-time location sharing with trusted contacts",
        "Integration with local emergency services",
        "Safe route suggestions",
        "Safety tips and resources",
        "Offline functionality for emergencies"
      ],
    ),
    Project(
      id: "health-app",
      title: "Health App",
      description: "A comprehensive health tracking application for monitoring fitness, nutrition, and wellness metrics.",
      imageUrl: "assets/images/health_app.png",
      technologies: ["Flutter", "Firebase", "Health APIs", "Charts"],
      githubUrl: "https://github.com/Namit24/HealthApp",
      detailedDescription: 
        "The Health App is a comprehensive solution for tracking and managing personal health metrics. "
        "It allows users to monitor their fitness activities, nutrition intake, sleep patterns, and other "
        "wellness metrics. The app provides personalized insights and recommendations based on user data.",
      features: [
        "Activity and exercise tracking",
        "Nutrition and diet monitoring",
        "Sleep pattern analysis",
        "Water intake tracking",
        "Health metrics visualization",
        "Personalized health insights",
        "Goal setting and progress tracking"
      ],
    ),
    Project(
      id: "no-code-ml",
      title: "No Code ML Platform",
      description: "A platform where users can build ML models using simple drag-and-drop technique without any coding required.",
      imageUrl: "assets/images/no_code_ml.png",
      technologies: ["Python", "Scikit-learn", "Streamlit", "Uvicorn"],
      githubUrl: "https://github.com/shaah1d/Nocode-V1",
      detailedDescription: 
        "The No Code ML Platform democratizes machine learning by allowing users with no programming "
        "experience to build and deploy ML models. Using a simple drag-and-drop interface, users can "
        "upload data, select features, choose algorithms, and generate models with just a few clicks. "
        "The platform handles all the complex preprocessing, training, and evaluation behind the scenes.",
      features: [
        "Drag-and-drop model building interface",
        "Automated data preprocessing",
        "Multiple algorithm selection",
        "Model performance visualization",
        "One-click model deployment",
        "Export functionality for trained models",
        "Interactive data exploration tools"
      ],
    ),
    Project(
      id: "imu-data-system",
      title: "DBMS & IMU Data System",
      description: "A comprehensive database and backend system to handle real-time IMU sensor data with admin and user dashboards.",
      imageUrl: "assets/images/imu_data_system.png",
      technologies: ["PostgreSQL", "Bluetooth", "Data Visualization", "Real-time CSV"],
      detailedDescription: 
        "The DBMS & IMU Data System is a sophisticated solution for handling real-time Inertial Measurement Unit (IMU) "
        "sensor data. It features a PostgreSQL database backend that efficiently stores and processes velocity, "
        "acceleration, joint angles, and timestamp data. The system includes Bluetooth connectivity for real-time "
        "CSV generation and comprehensive admin and user dashboards for data management and visualization.",
      features: [
        "Real-time IMU sensor data processing",
        "PostgreSQL database integration",
        "Bluetooth connectivity for data transfer",
        "Admin dashboard for session management",
        "User dashboard for exercise tracking",
        "Interactive data visualization",
        "Lapping functionality for data segmentation"
      ],
    ),
    Project(
      id: "android-bootcamp",
      title: "Android Development Bootcamp",
      description: "Workshop materials and example projects from the Android Development Bootcamp where I was a speaker.",
      imageUrl: "assets/images/android_bootcamp.png",
      technologies: ["Kotlin", "Android Studio", "Jetpack Compose", "Firebase"],
      detailedDescription: 
        "The Android Development Bootcamp is a comprehensive learning resource for beginners and intermediate "
        "developers looking to enhance their Android development skills. As one of the six speakers, I created "
        "workshop materials and example projects covering fundamental to advanced Android concepts. The bootcamp "
        "focuses on practical, hands-on learning with real-world application development.",
      features: [
        "Comprehensive Android development curriculum",
        "Hands-on coding exercises and projects",
        "Kotlin programming fundamentals",
        "UI design with Jetpack Compose",
        "Firebase integration tutorials",
        "App deployment and publishing guidance",
        "Performance optimization techniques"
      ],
    ),
    Project(
      id: "portfolio-app",
      title: "Portfolio App",
      description: "A beautiful Flutter portfolio app showcasing my skills, projects, and experience.",
      imageUrl: "assets/images/portfolio_app.png",
      technologies: ["Flutter", "Dart", "Animations", "UI/UX Design"],
      githubUrl: "https://github.com/Namit24/portfolio-app",
      detailedDescription: 
        "This Portfolio App is a showcase of my skills and projects, built with Flutter to demonstrate "
        "my capabilities in mobile app development. The app features a clean, modern design with smooth "
        "animations and transitions. It includes sections for my projects, skills, experience, and contact "
        "information, all presented in an intuitive and engaging user interface.",
      features: [
        "Responsive design for various screen sizes",
        "Dark and light theme support",
        "Smooth animations and transitions",
        "Project showcase with detailed views",
        "Skills and experience presentation",
        "Contact form integration",
        "Social media links and sharing"
      ],
    ),
  ];
}

