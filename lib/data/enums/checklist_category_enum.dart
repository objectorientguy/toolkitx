enum ChecklistCategory {
  electricSafety(category: 'Electric Safety'),
  production(category: 'Production'),
  pune(category: 'Pune'),
  steelImpact(category: 'Steel Impact'),
  testing(category: 'Testing');

  const ChecklistCategory({
    required this.category,
  });

  final String category;
}
