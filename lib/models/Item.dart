/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the Item type in your schema. */
class Item extends amplify_core.Model {
  static const classType = const _ItemModelType();
  final String id;
  final String? _name;
  final int? _quantity;
  final double? _usagePercentage;
  final ItemConsumptionLevel? _consumptionLevel;
  final bool? _active;
  final User? _user;
  final Slot? _slot;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  ItemModelIdentifier get modelIdentifier {
      return ItemModelIdentifier(
        id: id
      );
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int? get quantity {
    return _quantity;
  }
  
  double? get usagePercentage {
    return _usagePercentage;
  }
  
  ItemConsumptionLevel? get consumptionLevel {
    return _consumptionLevel;
  }
  
  bool? get active {
    return _active;
  }
  
  User? get user {
    return _user;
  }
  
  Slot? get slot {
    return _slot;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Item._internal({required this.id, required name, quantity, usagePercentage, consumptionLevel, active, user, slot, createdAt, updatedAt}): _name = name, _quantity = quantity, _usagePercentage = usagePercentage, _consumptionLevel = consumptionLevel, _active = active, _user = user, _slot = slot, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Item({String? id, required String name, int? quantity, double? usagePercentage, ItemConsumptionLevel? consumptionLevel, bool? active, User? user, Slot? slot}) {
    return Item._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      quantity: quantity,
      usagePercentage: usagePercentage,
      consumptionLevel: consumptionLevel,
      active: active,
      user: user,
      slot: slot);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Item &&
      id == other.id &&
      _name == other._name &&
      _quantity == other._quantity &&
      _usagePercentage == other._usagePercentage &&
      _consumptionLevel == other._consumptionLevel &&
      _active == other._active &&
      _user == other._user &&
      _slot == other._slot;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Item {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("quantity=" + (_quantity != null ? _quantity!.toString() : "null") + ", ");
    buffer.write("usagePercentage=" + (_usagePercentage != null ? _usagePercentage!.toString() : "null") + ", ");
    buffer.write("consumptionLevel=" + (_consumptionLevel != null ? amplify_core.enumToString(_consumptionLevel)! : "null") + ", ");
    buffer.write("active=" + (_active != null ? _active!.toString() : "null") + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("slot=" + (_slot != null ? _slot!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Item copyWith({String? name, int? quantity, double? usagePercentage, ItemConsumptionLevel? consumptionLevel, bool? active, User? user, Slot? slot}) {
    return Item._internal(
      id: id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      usagePercentage: usagePercentage ?? this.usagePercentage,
      consumptionLevel: consumptionLevel ?? this.consumptionLevel,
      active: active ?? this.active,
      user: user ?? this.user,
      slot: slot ?? this.slot);
  }
  
  Item copyWithModelFieldValues({
    ModelFieldValue<String>? name,
    ModelFieldValue<int?>? quantity,
    ModelFieldValue<double?>? usagePercentage,
    ModelFieldValue<ItemConsumptionLevel?>? consumptionLevel,
    ModelFieldValue<bool?>? active,
    ModelFieldValue<User?>? user,
    ModelFieldValue<Slot?>? slot
  }) {
    return Item._internal(
      id: id,
      name: name == null ? this.name : name.value,
      quantity: quantity == null ? this.quantity : quantity.value,
      usagePercentage: usagePercentage == null ? this.usagePercentage : usagePercentage.value,
      consumptionLevel: consumptionLevel == null ? this.consumptionLevel : consumptionLevel.value,
      active: active == null ? this.active : active.value,
      user: user == null ? this.user : user.value,
      slot: slot == null ? this.slot : slot.value
    );
  }
  
  Item.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _quantity = (json['quantity'] as num?)?.toInt(),
      _usagePercentage = (json['usagePercentage'] as num?)?.toDouble(),
      _consumptionLevel = amplify_core.enumFromString<ItemConsumptionLevel>(json['consumptionLevel'], ItemConsumptionLevel.values),
      _active = json['active'],
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _slot = json['slot']?['serializedData'] != null
        ? Slot.fromJson(new Map<String, dynamic>.from(json['slot']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'quantity': _quantity, 'usagePercentage': _usagePercentage, 'consumptionLevel': amplify_core.enumToString(_consumptionLevel), 'active': _active, 'user': _user?.toJson(), 'slot': _slot?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'quantity': _quantity,
    'usagePercentage': _usagePercentage,
    'consumptionLevel': _consumptionLevel,
    'active': _active,
    'user': _user,
    'slot': _slot,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<ItemModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<ItemModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final QUANTITY = amplify_core.QueryField(fieldName: "quantity");
  static final USAGEPERCENTAGE = amplify_core.QueryField(fieldName: "usagePercentage");
  static final CONSUMPTIONLEVEL = amplify_core.QueryField(fieldName: "consumptionLevel");
  static final ACTIVE = amplify_core.QueryField(fieldName: "active");
  static final USER = amplify_core.QueryField(
    fieldName: "user",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'User'));
  static final SLOT = amplify_core.QueryField(
    fieldName: "slot",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Slot'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Item";
    modelSchemaDefinition.pluralName = "Items";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Item.NAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Item.QUANTITY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Item.USAGEPERCENTAGE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Item.CONSUMPTIONLEVEL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Item.ACTIVE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Item.USER,
      isRequired: false,
      targetNames: ['userItemsId'],
      ofModelName: 'User'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Item.SLOT,
      isRequired: false,
      targetNames: ['slotItemsId'],
      ofModelName: 'Slot'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _ItemModelType extends amplify_core.ModelType<Item> {
  const _ItemModelType();
  
  @override
  Item fromJson(Map<String, dynamic> jsonData) {
    return Item.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Item';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Item] in your schema.
 */
class ItemModelIdentifier implements amplify_core.ModelIdentifier<Item> {
  final String id;

  /** Create an instance of ItemModelIdentifier using [id] the primary key. */
  const ItemModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'ItemModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is ItemModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}