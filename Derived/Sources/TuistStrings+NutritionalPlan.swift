    // swiftlint:disable all
    // swift-format-ignore-file
    // swiftformat:disable all
    // Generated using tuist — https://github.com/tuist/tuist
    import Foundation
    // swiftlint:disable superfluous_disable_command file_length implicit_return
    // MARK: - Strings
    // swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
    // swiftlint:disable nesting type_body_length type_name
    public enum NutritionalPlanStrings {
      /// Create
      public static let addCategoryAlertButtonTitle = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "add_category_alert_button_title")
      /// Enter the category name
      public static let addCategoryAlertMessage = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "add_category_alert_message")
      /// Category Name
      public static let addCategoryAlertTextfieldPlaceholder = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "add_category_alert_textfield_placeholder")
      /// Notes
      public static let addDishNotes = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "add_dish_notes")
      /// Select Category
      public static let categoriesViewTitle = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "categories_view_title")
      /// Category:
      public static let category = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "category")
      /// All
      public static let categoryTypeAllTitle = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "category_type_all_title")
      /// Carbohydrate
      public static let categoryTypeCarbohydrateTitle = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "category_type_carbohydrate_title")
      /// Fat
      public static let categoryTypeFatTitle = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "category_type_fat_title")
      /// Eating Out
      public static let categoryTypeOtherTitle = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "category_type_other_title")
      /// Protein
      public static let categoryTypeProteinTitle = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "category_type_protein_title")
      /// Other
      public static let categoryTypeUnknownTitle = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "category_type_unknown_title")
      /// Create
      public static let create = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "create")
      /// Daily Consumption
      public static let dailyConsumption = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "daily_consumption")
      /// Carbohydrates
      public static let dailyNutritionalValuesCarbohydrate = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "daily_nutritional_values_carbohydrate")
      /// Fat
      public static let dailyNutritionalValuesFat = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "daily_nutritional_values_fat")
      /// Proteins
      public static let dailyNutritionalValuesProtein = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "daily_nutritional_values_protein")
      /// Daily Summary
      public static let dailyReportTitle = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "daily_report_title")
      /// Amount
      public static let dishAmout = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "dish_amout")
      /// Dish Details
      public static let dishDetails = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "dish_details")
      /// Dish Name
      public static let dishName = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "dish_name")
      /// Carbohydrate: %@ Protein: %@ Fat: %@
      public static func dishNutritionalValuesDescription(_ p1: Any, _ p2: Any, _ p3: Any) -> String {
        return NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "dish_nutritional_values_description",String(describing: p1), String(describing: p2), String(describing: p3))
      }
      /// Unit
      public static let dishUnit = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "dish_unit")
      /// Dishes
      public static let dishesSectionTitle = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "dishes_section_title")
      /// Done
      public static let doneButton = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "done_button")
      /// Edit
      public static let editButtonTitle = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "edit_button_title")
      /// Favorites
      public static let favoritesTitle = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "favorites_title")
      /// Enter Value
      public static let insertValue = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "insert_value")
      /// Meals
      public static let mealsSectionTitle = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "meals_section_title")
      /// Menu
      public static let menuTitle = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "menu_title")
      /// Nutritional Values
      public static let nutritionalValues = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "nutritional_values")
      /// Carbohydrate
      public static let nutritionalValuesCarbohydrate = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "nutritional_values_carbohydrate")
      /// Fat
      public static let nutritionalValuesFat = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "nutritional_values_fat")
      /// Protein
      public static let nutritionalValuesProtein = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "nutritional_values_protein")
      /// Save
      public static let saveButtonTitle = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "save_button_title")
      /// Okay
      public static let saveDishErrorButton = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "save_dish_error_button")
      /// Please fill in all the required details: dish name, amount, and category.
      public static let saveDishErrorMessage = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "save_dish_error_message")
      /// Error
      public static let saveDishErrorTitle = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "save_dish_error_title")
      /// Daily Summary:\n%@
      public static func shareToWhatsappMessage(_ p1: Any) -> String {
        return NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "share_to_whatsapp_message",String(describing: p1))
      }
      /// Select Category
      public static let unknownCategory = NutritionalPlanStrings.tr(NutritionalPlanResources.bundle, "Localizable", "unknown_category")
    }
    // swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
    // swiftlint:enable nesting type_body_length type_name
    // MARK: - Implementation Details
    extension NutritionalPlanStrings {

      private static func tr(_ bundle: Bundle, _ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = bundle.localizedString(forKey: key, value: nil, table: table)
        let value = String(format: format, locale: Locale.current, arguments: args)
        if value != key || NSLocale.preferredLanguages.first == "he" {
            return value
        }
        // Fallback to he
        guard let path = bundle.path(forResource: "he", ofType: "lproj"),
              let defualtBundle = Bundle(path: path) else {
            return value
        }   
        return tr(defualtBundle, table, key, args)
      }
    }
    // swiftlint:disable convenience_type
    // swiftlint:enable all
    // swiftformat:enable all
