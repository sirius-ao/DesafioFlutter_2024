abstract interface class IStorage{
  dynamic get({ required String key});
  void remove({ required String key});
  void set({ required String key, required Object value });
}