import React, {useState, useEffect} from 'react';
import {
  View,
  Text,
  TextInput,
  Button,
  FlatList,
  StyleSheet,
} from 'react-native';

import firestore from '@react-native-firebase/firestore';

export default function App() {
  const [value, setValue] = useState('');
  const [data, setData] = useState<any[]>([]);

  // 📥 Load dữ liệu realtime
  useEffect(() => {
    const unsubscribe = firestore()
      .collection('duonghuyet')
      .orderBy('time', 'desc')
      .onSnapshot(snapshot => {
        const list: any[] = [];
        snapshot.forEach(doc => {
          list.push({
            id: doc.id,
            ...doc.data(),
          });
        });
        setData(list);
      });

    return () => unsubscribe();
  }, []);

  // 📤 Lưu dữ liệu
  const addData = async () => {
    if (!value) return;

    await firestore().collection('duonghuyet').add({
      value: Number(value),
      time: new Date(),
    });

    setValue('');
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>📊 Nhật ký đường huyết</Text>

      <TextInput
        style={styles.input}
        placeholder="Nhập chỉ số (vd: 120)"
        keyboardType="numeric"
        value={value}
        onChangeText={setValue}
      />

      <Button title="Lưu" onPress={addData} />

      <FlatList
        data={data}
        keyExtractor={(item) => item.id}
        renderItem={({item}) => (
          <View style={styles.item}>
            <Text style={styles.value}>🩸 {item.value}</Text>
            <Text style={styles.time}>
              {item.time?.toDate().toLocaleString()}
            </Text>
          </View>
        )}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    marginTop: 40,
  },
  title: {
    fontSize: 22,
    fontWeight: 'bold',
    marginBottom: 20,
  },
  input: {
    borderWidth: 1,
    padding: 10,
    marginBottom: 10,
    borderRadius: 8,
  },
  item: {
    padding: 10,
    borderBottomWidth: 1,
  },
  value: {
    fontSize: 18,
    fontWeight: 'bold',
  },
  time: {
    color: 'gray',
  },
});