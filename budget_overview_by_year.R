library(tidyverse)

budget_data <- read_csv("budget_spreadsheet.csv")

# Determine ordering based on 2023 values
ordered_categories <- budget_data %>%
  filter(Year == 2023) %>%
  arrange(Amount) %>%
  pull(Category)

# Convert Category to an ordered factor based on the 2023 ordering
budget_data$Category <- factor(budget_data$Category, levels = ordered_categories)

# Plot
budget_data %>%
  ggplot(aes(x = Category, y = Amount, fill = as.factor(Year))) +
  geom_col(position = "dodge") +
  geom_text(aes(label = scales::comma(Amount), group = as.factor(Year)),
            position = position_dodge(width = 0.9), hjust = -0.1, size = 3) +
  coord_flip() +
  scale_fill_manual(values = c("2023" = "lightgreen", "2024" = "lightblue"), name = "Year") +
  theme_minimal() +
  theme(
    axis.text.x = element_blank(),
    axis.text.y = element_text(),
    axis.ticks.y = element_blank(),
    axis.title.y = element_blank(),
    panel.grid.minor = element_blank(),
    legend.position = "bottom"
  ) +
  labs(x = "",
       y = "")
