# GrowthGuard Multi-language Support
# Medical translations reviewed by certified medical interpreters

# Language definitions
translations <- list(
  en = list(
    # App Title and Navigation
    app_title = "GrowthGuard",
    nav_welcome = "Welcome",
    nav_tracker = "Growth Tracker",
    nav_about = "About",
    nav_medical_info = "Medical Information",

    # Hero Section
    hero_title = "Welcome to GrowthGuard",
    hero_subtitle = "Track your child's growth with confidence using CDC-WHO standards",
    hero_cta = "Start Tracking Growth",

    # Feature Cards
    feature_charts_title = "Personalized Charts",
    feature_charts_desc = "Generate growth charts tailored to your child's data using CDC-WHO standards",
    feature_privacy_title = "Privacy First",
    feature_privacy_desc = "Your data never leaves your device. HIPAA compliant with no server storage",
    feature_export_title = "Export & Save",
    feature_export_desc = "Download charts as PDF and data as CSV for your medical records",

    # How It Works
    how_it_works_title = "How It Works",
    step1_title = "Enter Information",
    step1_desc = "Input your child's basic details: name, birth date, and current measurements",
    step2_title = "Generate Chart",
    step2_desc = "Our tool creates a personalized growth chart using CDC-WHO standards",
    step3_title = "Track & Export",
    step3_desc = "View results instantly and download for your medical records",

    # Form Steps
    progress_step1 = "Child Information",
    progress_step2 = "Chart Options",
    progress_step3 = "Results",

    # Step 1 - Child Information
    step1_icon_title = "Child Information",
    child_name_question = "What's your child's name?",
    child_name_placeholder = "Enter child's full name",
    child_name_help = "This will appear on the growth chart",
    gender_title = "Gender",
    measurements_title = "Current Measurements",
    height_label = "Height (inches)",
    height_help = "For example: 36.5 inches",
    weight_label = "Weight (pounds)",
    weight_help = "For example: 28.5 pounds",
    dates_title = "Important Dates",
    birth_date_label = "Date of Birth",
    birth_date_help = "When was your child born?",
    measurement_date_label = "Measurement Date",
    measurement_date_help = "When were these measurements taken?",
    continue_btn = "Continue to Chart Options",

    # Step 2 - Chart Options
    step2_icon_title = "Chart Options",
    chart_type_question = "What type of growth chart do you need?",
    chart_type_help = "Height-for-age tracks linear growth, while weight-for-age tracks weight gain",
    standards_title = "Growth Standards",
    standards_desc = "Internationally recognized growth charts combining CDC and WHO data for comprehensive tracking",
    back_btn = "Back",
    generate_btn = "Generate Growth Chart",

    # Step 3 - Results
    step3_icon_title = "Growth Chart Results",
    download_data_btn = "Download Data (CSV)",
    download_chart_btn = "Download Chart (PDF)",
    privacy_notice = "Privacy Protected: Your data is processed locally and never stored on our servers. This tool is HIPAA compliant.",
    new_calculation_btn = "New Calculation",

    # Medical Disclaimers
    medical_disclaimer_title = "⚠️ IMPORTANT MEDICAL DISCLAIMER",
    medical_disclaimer_main = "This tool is for informational and educational purposes ONLY and should NEVER replace professional medical advice, diagnosis, or treatment.",
    medical_disclaimer_points = list(
      "Always consult with your pediatrician or healthcare provider about your child's growth and development",
      "Growth charts show statistical ranges - every child grows at their own pace",
      "Concerning patterns should be evaluated by a qualified healthcare professional",
      "This tool does not diagnose medical conditions or provide medical advice",
      "Emergency concerns require immediate medical attention"
    ),

    # Validation Messages
    validation_name_required = "Please enter the child's name",
    validation_gender_required = "Please select gender",
    validation_height_required = "Please enter height",
    validation_weight_required = "Please enter weight",
    validation_birth_date_required = "Please enter birth date",
    validation_measurement_date_required = "Please enter measurement date",
    validation_chart_type_required = "Please select a chart type",
    validation_fill_all_fields = "Please fill in all required fields before continuing",

    # About Section
    about_title = "About GrowthGuard",
    data_sources_title = "Data Sources",
    data_sources_desc = "Our growth charts are based on:",
    privacy_security_title = "Privacy & Security",
    privacy_security_desc = "We take your privacy seriously:",

    # Gender Options
    gender_male = "Male",
    gender_female = "Female",

    # Chart Types
    chart_height_age = "Height for Age",
    chart_weight_age = "Weight for Age"
  ),

  es = list(
    # App Title and Navigation
    app_title = "GrowthGuard",
    nav_welcome = "Bienvenida",
    nav_tracker = "Monitor de Crecimiento",
    nav_about = "Acerca de",
    nav_medical_info = "Información Médica",

    # Hero Section
    hero_title = "Bienvenido a GrowthGuard",
    hero_subtitle = "Rastrea el crecimiento de tu hijo con confianza usando los estándares CDC-OMS",
    hero_cta = "Comenzar Seguimiento",

    # Feature Cards
    feature_charts_title = "Gráficos Personalizados",
    feature_charts_desc = "Genera gráficos de crecimiento adaptados a los datos de tu hijo usando estándares CDC-OMS",
    feature_privacy_title = "Privacidad Primero",
    feature_privacy_desc = "Tus datos nunca salen de tu dispositivo. Cumple con HIPAA sin almacenamiento en servidor",
    feature_export_title = "Exportar y Guardar",
    feature_export_desc = "Descarga gráficos como PDF y datos como CSV para tus registros médicos",

    # How It Works
    how_it_works_title = "Cómo Funciona",
    step1_title = "Ingresar Información",
    step1_desc = "Ingresa los detalles básicos de tu hijo: nombre, fecha de nacimiento y medidas actuales",
    step2_title = "Generar Gráfico",
    step2_desc = "Nuestra herramienta crea un gráfico de crecimiento personalizado usando estándares CDC-OMS",
    step3_title = "Rastrear y Exportar",
    step3_desc = "Ve los resultados al instante y descarga para tus registros médicos",

    # Form Steps
    progress_step1 = "Información del Niño",
    progress_step2 = "Opciones de Gráfico",
    progress_step3 = "Resultados",

    # Step 1 - Child Information
    step1_icon_title = "Información del Niño",
    child_name_question = "¿Cuál es el nombre de tu hijo/a?",
    child_name_placeholder = "Ingresa el nombre completo del niño/a",
    child_name_help = "Esto aparecerá en el gráfico de crecimiento",
    gender_title = "Sexo",
    measurements_title = "Medidas Actuales",
    height_label = "Altura (pulgadas)",
    height_help = "Por ejemplo: 36.5 pulgadas",
    weight_label = "Peso (libras)",
    weight_help = "Por ejemplo: 28.5 libras",
    dates_title = "Fechas Importantes",
    birth_date_label = "Fecha de Nacimiento",
    birth_date_help = "¿Cuándo nació tu hijo/a?",
    measurement_date_label = "Fecha de Medición",
    measurement_date_help = "¿Cuándo se tomaron estas medidas?",
    continue_btn = "Continuar a Opciones de Gráfico",

    # Step 2 - Chart Options
    step2_icon_title = "Opciones de Gráfico",
    chart_type_question = "¿Qué tipo de gráfico de crecimiento necesitas?",
    chart_type_help = "Altura-para-edad rastrea el crecimiento lineal, mientras peso-para-edad rastrea el aumento de peso",
    standards_title = "Estándares de Crecimiento",
    standards_desc = "Gráficos de crecimiento reconocidos internacionalmente que combinan datos CDC y OMS para seguimiento integral",
    back_btn = "Atrás",
    generate_btn = "Generar Gráfico de Crecimiento",

    # Step 3 - Results
    step3_icon_title = "Resultados del Gráfico de Crecimiento",
    download_data_btn = "Descargar Datos (CSV)",
    download_chart_btn = "Descargar Gráfico (PDF)",
    privacy_notice = "Privacidad Protegida: Tus datos se procesan localmente y nunca se almacenan en nuestros servidores. Esta herramienta cumple con HIPAA.",
    new_calculation_btn = "Nuevo Cálculo",

    # Medical Disclaimers
    medical_disclaimer_title = "⚠️ DESCARGO DE RESPONSABILIDAD MÉDICA IMPORTANTE",
    medical_disclaimer_main = "Esta herramienta es SOLO para fines informativos y educativos y NUNCA debe reemplazar el consejo, diagnóstico o tratamiento médico profesional.",
    medical_disclaimer_points = list(
      "Siempre consulta con tu pediatra o proveedor de atención médica sobre el crecimiento y desarrollo de tu hijo",
      "Los gráficos de crecimiento muestran rangos estadísticos - cada niño crece a su propio ritmo",
      "Los patrones preocupantes deben ser evaluados por un profesional de la salud calificado",
      "Esta herramienta no diagnostica condiciones médicas ni proporciona consejo médico",
      "Las preocupaciones de emergencia requieren atención médica inmediata"
    ),

    # Validation Messages
    validation_name_required = "Por favor ingresa el nombre del niño/a",
    validation_gender_required = "Por favor selecciona el sexo",
    validation_height_required = "Por favor ingresa la altura",
    validation_weight_required = "Por favor ingresa el peso",
    validation_birth_date_required = "Por favor ingresa la fecha de nacimiento",
    validation_measurement_date_required = "Por favor ingresa la fecha de medición",
    validation_chart_type_required = "Por favor selecciona un tipo de gráfico",
    validation_fill_all_fields = "Por favor completa todos los campos requeridos antes de continuar",

    # About Section
    about_title = "Acerca de GrowthGuard",
    data_sources_title = "Fuentes de Datos",
    data_sources_desc = "Nuestros gráficos de crecimiento se basan en:",
    privacy_security_title = "Privacidad y Seguridad",
    privacy_security_desc = "Tomamos tu privacidad en serio:",

    # Gender Options
    gender_male = "Masculino",
    gender_female = "Femenino",

    # Chart Types
    chart_height_age = "Altura para Edad",
    chart_weight_age = "Peso para Edad"
  )
)

# Translation function
t <- function(key, lang = "en") {
  if (lang %in% names(translations) && key %in% names(translations[[lang]])) {
    return(translations[[lang]][[key]])
  } else if (key %in% names(translations[["en"]])) {
    return(translations[["en"]][[key]])  # Fallback to English
  } else {
    return(key)  # Return key if translation not found
  }
}

# Get list as translated items for dropdown lists
t_list <- function(keys, lang = "en") {
  sapply(keys, function(key) t(key, lang), USE.NAMES = FALSE)
}