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
import 'package:collection/collection.dart';


/** This is an auto generated class representing the Slot type in your schema. */
class Slot extends amplify_core.Model {
  static const classType = const _SlotModelType();
  final String id;
  final String? _name;
  final User? _user;
  final Workspace? _workspace;
  final List<Item>? _items;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  SlotModelIdentifier get modelIdentifier {
      return SlotModelIdentifier(
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
  
  User? get user {
    return _user;
  }
  
  Workspace? get workspace {
    return _workspace;
  }
  
  List<Item>? get items {
    return _items;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Slot._internal({required this.id, required name, user, workspace, items, createdAt, updatedAt}): _name = name, _user = user, _workspace = workspace, _items = items, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Slot({String? id, required String name, User? user, Workspace? workspace, List<Item>? items}) {
    return Slot._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      user: user,
      workspace: workspace,
      items: items != null ? List<Item>.unmodifiable(items) : items);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Slot &&
      id == other.id &&
      _name == other._name &&
      _user == other._user &&
      _workspace == other._workspace &&
      DeepCollectionEquality().equals(_items, other._items);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Slot {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("workspace=" + (_workspace != null ? _workspace!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Slot copyWith({String? name, User? user, Workspace? workspace, List<Item>? items}) {
    return Slot._internal(
      id: id,
      name: name ?? this.name,
      user: user ?? this.user,
      workspace: workspace ?? this.workspace,
      items: items ?? this.items);
  }
  
  Slot copyWithModelFieldValues({
    ModelFieldValue<String>? name,
    ModelFieldValue<User?>? user,
    ModelFieldValue<Workspace?>? workspace,
    ModelFieldValue<List<Item>?>? items
  }) {
    return Slot._internal(
      id: id,
      name: name == null ? this.name : name.value,
      user: user == null ? this.user : user.value,
      workspace: workspace == null ? this.workspace : workspace.value,
      items: items == null ? this.items : items.value
    );
  }
  
  Slot.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _workspace = json['workspace']?['serializedData'] != null
        ? Workspace.fromJson(new Map<String, dynamic>.from(json['workspace']['serializedData']))
        : null,
      _items = json['items'] is List
        ? (json['items'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Item.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'user': _user?.toJson(), 'workspace': _workspace?.toJson(), 'items': _items?.map((Item? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'user': _user,
    'workspace': _workspace,
    'items': _items,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<SlotModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<SlotModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final USER = amplify_core.QueryField(
    fieldName: "user",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'User'));
  static final WORKSPACE = amplify_core.QueryField(
    fieldName: "workspace",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Workspace'));
  static final ITEMS = amplify_core.QueryField(
    fieldName: "items",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Item'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Slot";
    modelSchemaDefinition.pluralName = "Slots";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Slot.NAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Slot.USER,
      isRequired: false,
      targetNames: ['userSlotsId'],
      ofModelName: 'User'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Slot.WORKSPACE,
      isRequired: false,
      targetNames: ['workspaceSlotsId'],
      ofModelName: 'Workspace'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Slot.ITEMS,
      isRequired: false,
      ofModelName: 'Item',
      associatedKey: Item.SLOT
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

class _SlotModelType extends amplify_core.ModelType<Slot> {
  const _SlotModelType();
  
  @override
  Slot fromJson(Map<String, dynamic> jsonData) {
    return Slot.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Slot';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Slot] in your schema.
 */
class SlotModelIdentifier implements amplify_core.ModelIdentifier<Slot> {
  final String id;

  /** Create an instance of SlotModelIdentifier using [id] the primary key. */
  const SlotModelIdentifier({
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
  String toString() => 'SlotModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is SlotModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}